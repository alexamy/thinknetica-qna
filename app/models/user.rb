# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy
  has_many :answers, inverse_of: 'author', foreign_key: 'author_id', dependent: :destroy

  def owns?(resource)
    author_id = resource.try(:author_id)
    return unless author_id

    id == author_id
  end
end
