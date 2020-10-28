class Tweet < ApplicationRecord
  validates :text, presence: true #空白の投稿ができないように処理
  belongs_to :user #アソシエーション用
  has_many :comments  # commentsテーブルとのアソシエーション

  #whereメソッドとLIKE句を使用して検索の処理
  #テーブルとのやりとりに関するメソッドはモデルに置く
  def self.search(search)
    return Tweet.all unless search
    Tweet.where('text LIKE(?)', "%#{search}%")
  end

end
