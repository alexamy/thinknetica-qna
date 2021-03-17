# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :find_user, only: %i[create update set_as_best]
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[show destroy update set_as_best]

  def show; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.create(answer_params)
  end

  def update
    @answer.update(answer_params) if current_user.author_of?(@answer)
  end

  def destroy
    return unless current_user.author_of?(@answer)

    @answer.destroy
  end

  def set_as_best
    return unless @user.author_of?(@answer.question)

    @answer.set_as_best
  end

  private

  def find_user
    @user = User.find_by(id: current_user&.id)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: []).merge(author: current_user)
  end
end
