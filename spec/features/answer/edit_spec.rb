# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated user can not edit the answer', js: true do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    given!(:other_user) { create(:user) }
    given!(:other_answer) { create(:answer, question: question, author: other_user) }

    background { sign_in(user) }

    scenario 'edits his answer', js: true do
      visit question_path(question)

      within '.answers' do
        click_on 'Edit'
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to have_no_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to have_no_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors', js: true do
      visit question_path(question)

      within '.answers' do
        click_on 'Edit'
        fill_in 'Your answer', with: ''
        click_on 'Save'
      end

      expect(page).to have_content "Body can't be blank"
    end

    scenario "tries to edit other user's answer", js: true do
      visit question_path(question)

      within "#answer-#{other_answer.id}" do
        expect(page).to have_no_link 'Edit'
      end
    end
  end
end
