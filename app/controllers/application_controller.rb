class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

#deviseでログイン機能を実装した場合のパラメーターの受け取り方は通常とは異なる。
#ログイン時に送られてくるパラメーターを制限するストロングパラメーターは、deviseのGem内に記述されているため編集することはできません。
#deviseが提供しているconfigure_permitted_parametersメソッドを利用
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname]) #sign_upアクションに対して、nicknameというキーのパラメーターを追加で許可
  end

end
