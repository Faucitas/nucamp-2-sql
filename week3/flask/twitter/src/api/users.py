from flask import Blueprint, jsonify, abort, request
from ..models import User, Tweet, db, likes_table
import hashlib
import secrets


def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


def valid_input(input: str, valid_len: int):
    if len(input) < valid_len:
        print(f"invalid length, input must be {valid_len} characters")
        return False
    else:
        return True


bp = Blueprint('users', __name__, url_prefix='/users')


@bp.route('', methods=['GET'])
def index():
    users = User.query.all()
    result = []
    for user in users:
        result.append(user.serialize())
    return jsonify(result)


@bp.route('/<int:user_id>', methods=['GET'])
def show(user_id: int):
    user = User.query.get_or_404(user_id)
    return jsonify(user.serialize()), 200


@bp.route('', methods=['POST'])
def create():
    # request body must contain user_id and content
    body = request.json
    username = body['username']
    password = body['password']

    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)

    if not valid_input(username, 3) or not valid_input(password, 8):
        return abort(400)

    hashed_password = scramble(password)
    user = User(
        username=username,
        password=hashed_password
    )
    db.session.add(user)
    db.session.commit()
    return jsonify(user.serialize()), 201


@bp.route('/<int:user_id>', methods=['DELETE'])
def delete(user_id: int):
    user = User.query.get(user_id)
    try:
        db.session.delete(user)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:user_id>', methods=['PUT'])
def update(user_id: int):
    user = User.query.get_or_404(user_id)
    body = request.json

    if 'username' in body:
        new_username = body['username']
        if not valid_input(new_username, 3):
            return abort(400)
        else:
            user.username = new_username

    if 'password' in body:
        new_password = body['password']
        if not valid_input(new_password, 8):
            return abort(400)
        else:
            hashed_password = scramble(new_password)
            user.password = hashed_password

    db.session.commit()
    return jsonify(user.serialize()), 200


@bp.route('/<int:user_id>/liked_tweets', methods=['GET'])
def liking_users(user_id: int):
    user = User.query.get_or_404(user_id)
    results = []
    for tweet in user.liked_tweets:
        results.append(tweet.serialize())
    return jsonify(results), 200


@bp.route('/<int:user_id>/likes', methods=['POST'])
def like(user_id: int):
    body = request.json
    if 'tweet_id' not in body:
        return abort(400)

    user = User.query.get_or_404(user_id)
    tweet = Tweet.query.get_or_404(body['tweet_id'])
    try:
        insert_likes_query = likes_table.insert().values(user_id=user.id, tweet_id=tweet.id)
        db.session.execute(insert_likes_query)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


@bp.route('/<int:user_id>/likes/<int:tweet_id>', methods=['DELETE'])
def unlike(user_id: int, tweet_id: int):
    user = User.query.get_or_404(user_id)
    tweet = Tweet.query.get_or_404(tweet_id)
    delete_like = (
        likes_table.delete()
            .where(likes_table.c.user_id == user.id)
            .where(likes_table.c.tweet_id == tweet.id)
    )
    db.session.execute(delete_like)
    db.session.commit()
    return jsonify(delete_like.compile().params)
