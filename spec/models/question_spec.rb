# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_many(:links) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:best_answer).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :body }
  end

  it { is_expected.to accept_nested_attributes_for :links }

  describe 'answers_ordered' do
    subject(:question) { create(:question) }

    let(:answers) { create_list(:answer, 2, question: question) }

    it 'save order when there is no best answer' do
      expect(question.answers_ordered).to eq answers
    end

    it 'put the best answer as first' do
      answers[1].set_as_best
      question.reload

      expect(question.answers_ordered).to eq answers.reverse
    end
  end

  it 'have many attached files' do
    expect(described_class.new.files).to be_an_instance_of ActiveStorage::Attached::Many
  end
end
