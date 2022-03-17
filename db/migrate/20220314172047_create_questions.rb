class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    # Создание таблицы с полями
    # Автоматически создается поле id, т.е. дефолтный primary key
    create_table :questions do |t|
      t.string :title
      t.text :body

      # Два доп. поля - время создания и изменения вопроса
      t.timestamps
    end
  end
end
