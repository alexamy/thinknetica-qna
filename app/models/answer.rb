# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  def destroy_as(user)
    is_own = own_by?(user)

    destroy if is_own
    is_own
  end

  def own_by?(user)
    user.id == author.id
  end
end
