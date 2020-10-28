class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーションを繋ぐために定義しないといけない。1つのユーザがたくさんの情報を持っている関係を定義
  #対をなすtweetsの方にはbelong_to :userを定義する
  has_many :tweets 

  has_many :comments  # commentsテーブルとのアソシエーション

  validates :nickname, presence: true, length: { maximum: 6 }

end
