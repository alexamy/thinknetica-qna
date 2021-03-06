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
end
