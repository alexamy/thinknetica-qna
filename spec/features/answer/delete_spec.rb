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

  given!(:answer_with_files) { create(:answer, :with_files, question: question, author: user) }
  given!(:other_answer_with_files) { create(:answer, :with_files, question: question, author: other_user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'deletes his answer', js: true do
      within "#answer-#{answer.id}" do
        click_on 'Delete'
      end

      expect(page).to have_no_content answer.body
    end

    scenario 'tries to delete others answer' do
      within "#answer-#{other_answer.id}" do
        expect(page).to have_no_button 'Delete'
      end
    end

    scenario 'deletes file of his answer' do
      within "#answer-#{answer_with_files.id}" do
        within('.file') { click_on 'Delete' }
        expect(page).to have_no_link answer_with_files.files.first.filename.to_s
      end
    end

    scenario 'tries to delete file of others answer' do
      within "#answer-#{other_answer_with_files.id}" do
        within('.file') do
          expect(page).to have_no_link 'Delete'
        end
      end
    end
  end

  scenario 'Unauthenticated tries to delete answer' do
    visit question_path(question)

    within "#answer-#{other_answer.id}" do
      expect(page).to have_no_button 'Delete'
    end
  end
end
