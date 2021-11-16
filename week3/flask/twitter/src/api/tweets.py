from flask import Blueprint, jsonify, abort, request
from ..models import Tweet, User, db

bp = Blueprint('tweets', __name__, url_prefix='/tweets')


@bp.route('', methods=['GET'])
def index():
    tweets = Tweet.query.all()
    result = []
    for tweet in tweets:
        result.append(tweet.serialize())
    return jsonify(result)


@bp.route('/<int:tweet_id>', methods=['GET'])
def show(tweet_id: int):
    tweet = Tweet.query.get_or_404(tweet_id)
    return jsonify(tweet.serialize())


@bp.route('', methods=['POST'])
def create():
    # request body must contain user_id and content
    body = request.json
    if 'user_id' not in body or 'content' not in body:
        return abort(400)
    # check if user exists
    User.query.get_or_404(body['user_id'])
    # construct tweet
    tweet = Tweet(
        user_id=body['user_id'],
        content=body['content']
    )
    db.session.add(tweet)
    db.session.commit()
    return jsonify(tweet.serialize())


@bp.route('/<int:tweet_id>', methods=['DELETE'])
def delete(tweet_id: int):
    tweet = Tweet.query.get(tweet_id)
    try:
        db.session.delete(tweet)
        db.session.commit()
        return jsonify(True), 200
    except:
        return jsonify(False), 200


@bp.route('/<int:tweet_id>/liking_users', methods=['GET'])
def liking_users(tweet_id: int):
    tweet = Tweet.query.get_or_404(tweet_id)
    results = []
    for user in tweet.likes:
        results.append(user.serialize())
    return jsonify(results), 200
