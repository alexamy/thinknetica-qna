# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  validates :title, :body, presence: true

  def answers
    answers = super
    return answers unless best_answer

    [best_answer] + answers.reject(&:best?)
  end
end
