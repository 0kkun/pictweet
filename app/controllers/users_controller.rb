
#なんでこの時だけコントローラー新たに作るのか？意味わからない

class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets
    @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC") #最新順(oder)とページネーション(per)を実装
  end
end
