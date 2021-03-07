# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject(:answer) { create(:answer) }

  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to have_one(:question_where_is_best) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe 'set_as_best' do
    it 'sets as the best answer' do
      answer.set_as_best
      expect(answer.question.best_answer).to be answer
    end
  end

  describe 'best?' do
    it 'is false when answer is not marked as best' do
      expect(answer).not_to be_best
    end

    it 'is true when answer is marked as best' do
      answer.set_as_best
      expect(answer).to be_best
    end
  end
end
