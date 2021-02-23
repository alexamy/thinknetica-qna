# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'

  validates :title, :body, presence: true

  def destroy_as(user)
    is_own = own_by?(user)

    destroy if is_own
    is_own
  end

  def own_by?(user)
    user.id == author.id
  end
end
