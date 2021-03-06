class MainController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: 'desc').page(params[:page])
    @user_likes = Like.where(user_id: current_user.id).pluck(:tweet_id)
  end

  def show
    @tweet = Tweet.find(params[:tweet])
    @user_likes = Like.where(user_id: current_user.id).pluck(:tweet_id)
  end

  def create_tweet
    logger.info(@user_likes)
    @tweet = Tweet.new
    @tweet.content = params[:content]
    @tweet.user = current_user
    if @tweet.save
      flash[:notice] = 'Tweet sent!'
      redirect_to :root
    else
      @tweets = Tweet.order(created_at: 'desc').page(params[:page])
      flash[:alert] = 'Content is mandatory'
      render :index
    end
  end

  def like_tweet
    @tweet = Tweet.find(params[:tweet])
    @like = Like.new
    @like.tweet = @tweet
    @like.user = current_user
    @like.save
    flash[:notice] = "Tweet liked!"
    redirect_to :root
  end

  def unlike_tweet
    @like = Like.where(user_id: current_user.id).where(tweet_id: params[:tweet]).first
    @like.destroy
    flash[:notice] = "Tweet unliked!"
    redirect_to :root
  end

  def retweet
    @original = Tweet.find(params[:tweet])
    @tweet = Tweet.new
    @tweet.content = @original.content
    @tweet.user = current_user
    @tweet.tweet_id = @original.id
    @tweet.save
    @original.retweets = @original.retweets + 1
    @original.save
    flash[:notice] = 'Tweet retweeted!'
    redirect_to :root
  end
end
