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

  scenario 'Authenticated user deletes his question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete'

    expect(page).to have_content 'Question was successfully deleted.'
    expect(page).not_to have_content question.title
  end

  scenario 'User tries to delete others question' do
    visit question_path(other_question)

    expect(page).to have_no_button 'Delete'
  end
end
