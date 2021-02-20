# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'example@test.com' }
    password { '123456' }
  end
end
