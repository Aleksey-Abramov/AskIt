class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: {minimum: 5}

  def formatted_created_at
    # Метод, который форматирует дату создания
    # self - явно указывает, что метод вызывается относительно конкретного образца класса (можно не указывать)
    self.created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
