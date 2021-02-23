# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete answer', "
  In order to remove wrong answer
  As an authenticated user
  I'd like to be able to delete my own answer
" do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }

  given(:question) { create(:question, author: user) }

  given!(:answer) { create(:answer, question: question, author: user) }
  given!(:other_answer) { create(:answer, question: question, author: other_user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'deletes his answer' do
      within('tr', text: answer.body) { click_on 'Delete' }

      expect(page).to have_content 'Answer was successfully deleted.'
    end

    scenario 'tries to delete others answer' do
      within('tr', text: other_answer.body) { click_on 'Delete' }

      expect(page).to have_content "Can't delete someone else's answer"
    end
  end

  scenario 'Unauthenticated user tries to delete answer' do
    visit question_path(question)

    within('tr', text: answer.body) { click_on 'Delete' }

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
