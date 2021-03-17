# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit question', "
  In order to correct question
  As an author of question
  I'd like to be able to edit my question
  " do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }

  given!(:question) { create(:question, author: user) }
  given!(:question_with_files) { create(:question, :with_files, author: user) }
  given!(:other_question) { create(:question, author: other_user) }

  scenario 'Unauthenticated user can not edit the question', js: true do
    visit question_path(question)

    within '.question' do
      expect(page).to have_no_link 'Edit'
    end
  end

  describe 'Authenticated user' do
    background { sign_in(user) }

    scenario 'edits his question', js: true do
      visit question_path(question)

      within '.question' do
        click_on 'Edit'
        fill_in 'Question', with: 'edited question'
        click_on 'Save'

        expect(page).to have_no_content question.body
        expect(page).to have_content 'edited question'
        expect(page).to have_no_selector 'textarea#question_body'
      end
    end

    scenario 'edits his question with errors', js: true do
      visit question_path(question)

      within '.question' do
        click_on 'Edit'
        fill_in 'Question', with: ''
        click_on 'Save'
      end

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'edits his question with files', js: true do
      visit question_path(question_with_files)

      within('.question') { click_on 'Edit' }
      within "#edit-question-#{question_with_files.id}" do
        attach_file 'Files', ["#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'
      end

      within '.question' do
        expect(page).to have_link 'spec_helper.rb'
        question_with_files.files.each do |file|
          expect(page).to have_link file.filename.to_s
        end
      end
    end

    scenario "tries to edit other user's question", js: true do
      visit question_path(other_question)

      within '.question' do
        expect(page).to have_no_link 'Edit'
      end
    end
  end
end
