# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question', "
  In order to remove undesired question
  As an authenticated user
  I'd like to be able to delete my own question
" do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }

  given(:question) { create(:question, author: user) }
  given(:other_question) { create(:question, author: other_user) }

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'deletes his question' do
      visit question_path(question)
      click_on 'Delete'

      expect(page).to have_content 'Question was successfully deleted.'
    end

    scenario 'tries to delete others question' do
      visit question_path(other_question)
      click_on 'Delete'

      expect(page).to have_content "Can't delete someone else's question"
    end
  end

  scenario 'Unauthenticated user tries to delete question' do
    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
