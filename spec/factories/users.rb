FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}

    # 複数tweetを作成する時に同じemailを使用するとバリデーションに引っかかってエラーになるので、
    # Fakerを使って異なるものになるようにします。FakerはGemをインストールする
    sequence(:email) {Faker::Internet.email}
  end

end