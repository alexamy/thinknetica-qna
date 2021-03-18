# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :question }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :url }
  end
end
