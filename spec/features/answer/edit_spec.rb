# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Unauthenticated user can not edit the answer' do
    visit question_path(question)

    expect(page).to have_no_link 'Edit'
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'edit his answer', js: true do
      visit question_path(question)

      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to have_no_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to have_no_selector 'textarea'
      end
    end

    scenario 'edit his answer with errors'
    scenario "tries to edit other user's answer"
  end
end
