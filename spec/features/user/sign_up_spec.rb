# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign up', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign up
" do

  given(:user) { create(:user) }

  describe 'Unauthenticated user' do
    scenario 'tries to sign up' do
      visit new_user_registration_path

      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: '12345678'
      fill_in 'Password confirmation', with: '12345678'
      click_on 'Sign up'

      expect(page).to have_content 'You have signed up successfully.'
    end

    scenario 'tries to sign up with errors'
  end

  scenario 'Authenticated user tries to sign up'
end
