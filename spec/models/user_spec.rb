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

  describe 'owns?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:question) { create(:question, author: user) }
    let(:other_question) { create(:question, author: other_user) }

    it 'is true when asked for owned object' do
      expect(user.owns?(question)).to be true
    end

    it "is false when asked for someone else's object" do
      expect(user.owns?(other_question)).to be false
    end

    it 'is nil when asked for object without author' do
      expect(user.owns?({})).to be nil
    end
  end
end
