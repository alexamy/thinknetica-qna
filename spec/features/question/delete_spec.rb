# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question', "
  In order to remove undesired question
  As an authenticated user
  I'd like to be able to delete my own question
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'deletes his question' do
      click_on 'Delete'

      expect(page).to have_content('Question was successfully deleted.')
    end

    scenario 'tries to delete others question'
  end

  scenario 'Unauthenticated user tries to delete question'
end
