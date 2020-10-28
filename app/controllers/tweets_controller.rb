class TweetsController < ApplicationController

  before_action :set_tweet, only: [:edit, :show]

  #もし、ユーザーがログインしていなかったらindexアクションにリダイレクトする
  #before_action :move_to_index, except: [:index, :show]

  def index
    #@tweets = Tweet.all
    #@tweets = Tweet.includes(:user) #N+1問題を解決するためincludeを使用する
    #@tweets = Tweet.includes(:user).order("created_at DESC") #oder メソッドで並び順を工夫する
    @tweets = Tweet.includes(:user).order("created_at DESC").page(params[:page]).per(5) #1ページあたりに表示する件数を指定する
    
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def destroy #ビューにツイート情報を受け渡す必要が無いのでインスタンスではなくただの変数を使う
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  # def edit #編集
  #   @tweet = Tweet.find(params[:id]) #idを目印にデータベースとやり取りして編集する
  # end

  def update #編集したものを更新
    tweet = Tweet.find(params[:id]) #ビューにツイート情報を受け渡す必要が無いのでインスタンスではなくただの変数を使う
    tweet.update(tweet_params)
  end

   def show
  #   @tweet = Tweet.find(params[:id])
      @comment = Comment.new
      @comments = @tweet.comments.includes(:user)
   end

   def search
    @tweets = Tweet.search(params[:keyword])
  end

  private
  def tweet_params
    #params.require(:tweet).permit(:name, :image, :text)
    #params.require(:tweet).permit(:name, :image, :text).merge(user_id: current_user.id) #margeを使って現在ログイン中のユーザidも追加
    params.require(:tweet).permit(:image, :text)
  end
  
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index #自分でメソッド名を命名。before_actionにユーザーがサインインしているかどうかの情報を渡す
    redirect_to action: :index unless user_signed_in?
  end


end
