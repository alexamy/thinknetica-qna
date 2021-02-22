# frozen_string_literal: true

require 'rails_helper'

feature 'User can add an answer', "
  In order to help other people
  As an authenticated user
  I'd like to add an answer for a question
" do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  describe 'Authenticated user' do
    scenario 'adds an answer' do
      fill_in 'Answer', with: 'Test answer body'
      click_on 'Add answer'

      expect(page).to have_content('Your answer was successfully created')
      expect(page).to have_content('Test answer body')
    end

    scenario 'adds an answer with errors' do
      click_on 'Add answer'

      expect(page).to have_content("Body can't be blank")
    end
  end

  scenario 'Unauthenticated user tries to add an answer'
end
