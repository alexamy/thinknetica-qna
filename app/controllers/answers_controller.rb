class AnswersController < ApplicationController
  before_action :find_question, only: %i[new create show]
  before_action :find_answer, only: %i[show]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    render :new unless @answer.save
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
