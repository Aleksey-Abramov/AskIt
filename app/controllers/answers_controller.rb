class AnswersController < ApplicationController

  before_action :set_question!
  before_action :set_answer!, except: :create

  def create
    # Создание вопроса
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      # Нужно переопределить в случае render
      @answers = @question.answers.order created_at: :desc
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted!"
    redirect_to question_path(@question)
  end

  def edit
  end

  def update
    if @answer.update answer_params
      flash[:success] = "Answer updated!"
      # Если сохранили, то перенаправляем на другую страницу - страницу всех вопросов
      redirect_to question_path(@question)
    else
      # Если сохранить не удалось, тогда еще раз отрендерить представление (view) new.html.erb
      render :edit
    end
  end

  private

  def answer_params
    # Метод просто достает и body ответа из параметров для дальнейшей работы с ними
    params.require(:answer).permit(:body)
  end

  def set_question!
    # Проверка - есть такой вопрос или нет
    @question = Question.find params[:question_id]
  end

  def set_answer!
    @answer = @question.answers.find params[:id]
  end
end