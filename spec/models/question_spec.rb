# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:answers) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:best_answer).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end

  describe 'best_answer=' do
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question) }

    let(:other_question) { create(:question) }
    let(:other_answer) { create(:answer, question: other_question) }

    it 'assigns the best answer' do
      question.best_answer = answer
      expect(question.best_answer).to be answer
    end

    it 'restrict using answer from other question' do
      question.best_answer = other_answer
      expect(question.best_answer).to be_nil
    end
  end
end
