class AnswersController < ApplicationController

  before_action :set_question!

  def create
    # Создание вопроса
    @answer = @question.answers.build answer_params

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question)
    else
      # Нужно переопределить в случае render
      @answers = Answer.order created_at: :desc
      render 'questions/show'
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    flash[:success] = "Answer deleted!"
    redirect_to question_path(@question)
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
end