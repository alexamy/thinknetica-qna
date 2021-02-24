# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:questions) }
    it { is_expected.to have_many(:answers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

  describe 'owner_of?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:question) { create(:question, author: user) }
    let(:other_question) { create(:question, author: other_user) }

    it 'is true when asked for owned object' do
      expect(user).to be_owner_of(question)
    end

    it "is false when asked for someone else's object" do
      expect(user).not_to be_owner_of(other_question)
    end
  end
end
