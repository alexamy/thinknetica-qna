require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'validates presence of title' do
    question = Question.new(body: 'abc')
    expect(question).to_not be_valid
  end
end
