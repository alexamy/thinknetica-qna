# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:author) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe 'set_as_best' do
    subject(:answer) { create(:answer) }

    it 'sets as the best answer' do
      answer.set_as_best
      expect(answer.question.best_answer).to be answer
    end
  end
end
