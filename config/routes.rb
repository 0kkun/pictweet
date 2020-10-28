Rails.application.routes.draw do

  devise_for :users
  root to: 'tweets#index' #/にアクセスするとtweets_controllerのindexアクションを呼ぶように設定
  #index : tweetsというパスを指定すると、tweetsコントローラーのindexアクションの処理を実行することができるようになる
  #new : 新規投稿にアクセスした時にtweetsコントローラーのnewアクションが動くようになる
  #create : 入力内容に応じてツイートをテーブルに保存するようにできる
  #destroy : 投稿したものを削除できるルーティングを追加

  #コメントを投稿する機能の実装。doとendで挟むことで中の記述をネスト(入れ子関係化)
  #paramsのなかにtweet_idというキーが追加され、コントローラーで扱うことができます。
  #ネストしないと、コメントと結びつくツイートのid情報が送れない
  #tweetsが親、commentsが子の関係ができる
  #アソシエーション先のレコードのidをparamsに追加してコントローラーに送るため
  resources :tweets do
    resources :comments, only: :create
    #7つの基本アクションを定義する際にcollectionとmemberがある
    #collectionは:idがつかない。memberは:idがつく。
    collection do
      get 'search'
    end
  end
  
  #/users/:idのパスでアクセスした際にusers_controller.rbのshowアクションを呼ぶルーティングを設定
  resources :users, only: :show
end
