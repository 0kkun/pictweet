
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    #commentsテーブルに必要なカラムの情報を追加
    create_table :comments do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.text :text
      t.timestamps
    end
  end
end
