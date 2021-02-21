# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign up', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign up
" do

  given(:user) { create(:user) }

  describe 'Unauthenticated user' do
    scenario 'try to sign up'
    scenario 'try to sign up with errors'
  end

  scenario 'Authenticated user try to sign up'
end
