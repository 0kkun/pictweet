require 'rails_helper'

#HTTPメソッドのGETのリクエストが来てnewアクションが実行されると、newのビューが表示されるかのテスト
#アクション名の前には#をつけるのがルール
describe TweetsController do
  describe 'GET #new' do
    it "renders the :new template" do
      #擬似的にnewアクションを動かすリクエストを行うコードを書く
      # (例) get :show, params: {  id: 1 }
      get :new # <--渡すパラメータは何もないのでこれで良い。

      #new.html.erbに遷移することを確かめるコードを書く
      #expectメソッドにresponseと言う引数(変数)を渡し、render_templateメソッドの返り値と比較
      #render_template :アクション名  マッチャの一つ。アクションに対して自動的に遷移するビューを返す
      expect(response).to render_template :new
    end
  end

  # -------editアクションを確かめるコード-------
  # インスタンス変数の値を確かめるテスト
  # editアクションを実行する時には、tweetsテーブルに値が入ってないとダメ
  # 先にデータベースに値を登録しておき、editアクションでインスタンス変数を呼び出し、
  # それが予めFactoryBotで定義しておいた変数と一致するかどうかを確認している
  # describe 'GET #edit' do

    it "assigns the requested tweet to @tweet" do
      # createメソッドでtweetをデータベースへ保存。:tweetはFactoryBotで中身が指定されている
      tweet = create(:tweet)
      # 擬似リクエストを作成。httpメソッドのgetリクエストが来たら、editアクション実行。
      # この書き方で、キーidに、tweet変数に入っているバリューを入れることができる
      get :edit, params: { id: tweet }
      # assings(インスタンス変数)  インスタンス変数をテストするためのメソッド
      # リクエストされたeditアクションの中で定義されている@tweetが、
      # 間違いなくこちらで作成しているtweetとなっているか
      expect(assigns(:tweet)).to eq tweet
    end

    #editアクションが実行された時に、edit.html.erbに遷移するかのテスト
    it "renders the :edit template" do
      tweet = create(:tweet)
      get :edit, params: { id: tweet }
      expect(response).to render_template :edit
    end
  end

  # ------indexアクションのテストコード-------
  describe 'GET #index' do
    # インスタンス変数の値を確かめる
    # コントローラーのindexアクションではまずテーブルから全てのレコードを取得してきている
    # 複数のレコードが必要
    it "populates an array of tweets ordered by created_at DESC" do
      # create_listメソッド 複数テーブルを作成できる
      # create_list(リソース, 個数)
      tweets = create_list(:tweet, 3)
      get :index
      # match 引数に配列クラスのインスタンスをとり、expectの引数と比較するマッチャ
      # indexアクション内のインスタンス変数tweetは、created_atで降順にソートしている
      # その状態を再現
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    # 正しいページに遷移するかを確かめるテストコード
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
  
end