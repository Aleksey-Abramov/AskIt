class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ErrorHandling

  private

  # Проверка сессии: вошел пользователь в систему или нет
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  # Прверка находится пользователь в системе или нет
  def user_signed_in?
    current_user.present?
  end

  # Методы доступны не только в контроллерах, но и в формах, т.е. сделаем их хелперами
  helper_method :current_user, :user_signed_in?
end
