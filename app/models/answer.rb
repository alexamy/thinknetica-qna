# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def set_as_best
    question.update(best_answer: self)
  end

  def best?
    question.best_answer_id == id
  end
end
