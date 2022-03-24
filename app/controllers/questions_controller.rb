# Создали контроллер, которые будет отображать все вопросы
class QuestionsController < ApplicationController

  # Вынесем повторяющуюся часть, которая будет выполняться перед нужными методами
  before_action :set_question!, only: %i[show destroy edit update]

  def index
    # Методы вытаскивает из БД все вопросы и запихивает в переменную, которую потом будем использовать для отображения
    @questions = Question.all
  end

  def new
    # Метод создает новый вопрос, а точнее отображает форму создания нового вопроса
    # Сначала инстанцируем (создаем) новый класс-вопрос, пользователь его сам заполняет и после этого сохраняем его, т.е. кладем в БД
    @question = Question.new
    # Заполнение вопросов происходит в форме views -> questions -> new.html.erb
  end

  def create
    # Метод обрабатывает создание нового, а точнее обрабатывает форму создания

    # render - вывод какой-то другой информации, отличной от представлений
    # plain - просто текст (та самая другая инфорация, которую рендерим)
    # params - все параметры запроса, которые пришли
    # render plain: params

    # Нужно создать новый вопрос с параметрами из формы создания, для этого исп приватный метод
    @question = Question.new question_params

    # Создали вопрос, сохраняем его и что-то делаем в зависимости от успешного (или нет) сохранения
    if @question.save
      # Всплывающее окно, что создали новую запись
      # :success - ключ, к которому можно обратиться в форме
      flash[:success] = "Question created!"
      # Если сохранили, то перенаправляем на другую страницу - страницу всех вопросов
      redirect_to questions_path
    else
      # Если сохранить не удалось, тогда еще раз отрендерить представление (view) new.html.erb
      render :new
    end
  end

  def edit
    # Метод для изменения вопроса, а точнее отображает форму редактирования
    # Ищем вопрос, который надо изменить
    # id: - то поле в БД, по которому осуществляется поиск
    # params - объект, где лежат все параметры запроса
    # [:id] - параметр запроса, который берется из url
    # Перенесли в set_question
    # @question = Question.find_by id: params[:id]
  end

  def update
    # Метод для изменения вопроса, а точнее обрабатывает форму редактирования
    # Ищем вопрос, который надо изменить
    # Перенесли в set_question
    # @question = Question.find_by id: params[:id]
    # Изменили вопрос, запихнули в него новые параметры и обновляем его
    if @question.update question_params
      flash[:success] = "Question updated!"
      # Если сохранили, то перенаправляем на другую страницу - страницу всех вопросов
      redirect_to questions_path
    else
      # Если сохранить не удалось, тогда еще раз отрендерить представление (view) new.html.erb
      render :edit
    end
  end

  def destroy
    # Метод для удаления вопросов, втч из БД
    # Перенесли в set_question
    # @question = Question.find_by id: params[:id]
    @question.destroy
    flash[:success] = "Question deleted!"

    redirect_to questions_path
  end

  def show
    # Метод для просмотра вопроса, т.е. отображение формы просмотра
    # Перенесли в set_question
    #@question = Question.find_by id: params[:id]
    # Привязываем ответ к вопросу
    @answer = @question.answers.build
    # Отображение ответов к конкретному вопросу (:desc - сортировка по убыванию - новый наверху)
    @answers = Answer.order created_at: :desc
  end

  private
  def question_params
    # Метод просто достает title и body вопроса из параметров для дальнейшей работы с ними
    # permit - разрешает создать и работать с теми параметрами, которые мы явно указали - защита от дурака, чтобы не меняли то, что не надо
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    # Добавили обработку ошибок в случае, если id не существует
    @question = Question.find params[:id]
  end
end

# Методы index, new (по уолчанию)- выдают содержимое наших представлений (views)
# Для иных действий (вывода чего-то иного) используется метод 'render'