class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      #必要なカラムを定義する！
      t.string :name
      t.string :text
      t.text :image
      t.timestamps
    end
  end
end