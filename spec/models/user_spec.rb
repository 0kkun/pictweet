require 'rails_helper' # rails_helper.rb内の記述を読み込むことで共通の設定を有効


#----------nicknameが空の場合登録できないことを確かめるテストコード-----------
#ターミナルでbundle exec rspecを実行すれば、下記テストを実行できる

# ***** Sample 1 ******
describe User do # Userクラスのcreateメソッド(アクション)をテストする
  describe '#create' do # ネスト(入れ子)化。メソッド名の前には#をつける

    it "is invalid without a nickname" do
      user = User.new(nickname: "", email: "kkk@gmail.com", password: "00000000", password_confirmation: "00000000")
      user.valid? # valid?メソッド:バリデーションにより保存ができない状態であるか？をチェック
      expect(user.errors[:nickname]).to include("can't be blank")

    end
  end
end



# ***** Sample 2 ******
# Factory_botを用いた記述
# nicknameとemailが空の場合登録できないことを確かめるテストコード
# Userクラスのcreateメソッド(アクション)をテストする

# describe User do 
#   describe '#create' do #ネスト(入れ子)化。メソッド名の前には#をつける

#     it "is invalid without a nickname" do
#       #user変数に、userクラスを入れる。ただしnicknameだけ空の状態で値を入れる。
#       user = build(:user, nickname: nil) #buildの中に、Fatory_botに渡したい値を指定する

#       # userにvalid?メソッドを実行する
#       # valid?メソッド:バリデーションにより保存ができない状態であるか？をチェック
#       # 返り値はtrueまたはfalseとなる
#       user.valid? 

#       # valid?メソッドを利用したインスタンス対してerrorsメソッドを利用すると
#       # バリデーションにより保存ができない状態である場合なぜできないのかを確認することができる
#       expect(user.errors[:nickname]).to include("can't be blank")
#     end

#     #emailが空の場合のテストコード
#     it "is invalid without a email" do
#       user = build(:user, email: nil)
#       user.valid?
#       expect(user.errors[:email]).to include("can't be blank")
#     end

#   end
# end


# ***** Sample 3 ******

# nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
# nicknameが空では登録できないこと
# emailが空では登録できないこと
# passwordが空では登録できないこと
# passwordが存在してもpassword_confirmationが空では登録できないこと
# nicknameが7文字以上であれば登録できないこと
# nicknameが6文字以下では登録できること
# 重複したemailが存在する場合登録できないこと
# passwordが6文字以上であれば登録できること
# passwordが5文字以下であれば登録できないこと

describe User do
  describe '#create' do
    # 1. nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # 6. nicknameが7文字以上であれば登録できないこと
    it "is invalid with a nickname that has more than 7 characters " do
      user = build(:user, nickname: "aaaaaaaa")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    # 7. nicknameが6文字以下では登録できること
    it "is valid with a nickname that has less than 6 characters " do
      user = build(:user, nickname: "aaaaaa")
      expect(user).to be_valid
    end

    # 8. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # 9. passwordが6文字以上であれば登録できること
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    # 10. passwordが5文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end