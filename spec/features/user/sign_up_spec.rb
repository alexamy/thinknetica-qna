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

    # didnt add test cases for incorrect email and short password
    # because it's handled by devise gem internally
    scenario 'tries to sign up with errors' do
      visit new_user_registration_path

      click_on 'Sign up'

      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
    end
  end

  scenario 'Authenticated user tries to sign up'
end
