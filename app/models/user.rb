class User < ApplicationRecord
  # Добавили хэширование пароля
  has_secure_password
  # Валидации на уровне программного кода
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
