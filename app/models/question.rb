# ApplicationRecord - позволяет работать с таблицами БД как с классами языка, чтобы не писать сырые sql-запросы
# Тут описывается бизнес-логика работы с данными!
class Question < ApplicationRecord
  # Добавили связь с ответами, указав тип связи, а также удаление связей, чтобы при удалении вопроса удалялись ответы
  has_many :answers, dependent: :destroy

  # Добавим валидацию, чтобы заголовок и тело вопроса не были пустыми
  validates :title, presence: true, length: {minimum: 2}
  validates :body, presence: true, length: {minimum: 2}

  def formatted_created_at
    # Метод, который форматирует дату создания
    # self - явно указывает, что метод вызывается относительно конкретного образца класса (можно не указывать)
    self.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
