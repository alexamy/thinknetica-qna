# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  has_one :question_where_is_best,
          class_name: 'Question',
          foreign_key: 'best_answer_id',
          inverse_of: 'best_answer',
          dependent: :nullify

  validates :body, presence: true

  def set_as_best
    question.update(best_answer: self)
  end

  def best?
    question.best_answer_id == id
  end
end
