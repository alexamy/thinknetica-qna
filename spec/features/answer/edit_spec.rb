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
    given!(:answer_with_files) { create(:answer, :with_files, question: question, author: user) }

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

    scenario 'edits his answer with files', js: true do
      visit question_path(question)

      within "#answer-#{answer_with_files.id}" do
        click_on 'Edit'
        attach_file 'Files', ["#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'

        expect(page).to have_link 'spec_helper.rb'
        answer_with_files.files.each do |file|
          expect(page).to have_link file.filename.to_s
        end
      end
    end

    scenario "tries to edit other user's answer", js: true do
      visit question_path(question)

      within "#answer-#{other_answer.id}" do
        expect(page).to have_no_link 'Edit'
      end
    end
  end
end
