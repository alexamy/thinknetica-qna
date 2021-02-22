# frozen_string_literal: true

require 'rails_helper'

feature 'User can view answers for question', "
  In order to find answer for question
  As an unauthenticated user
  I'd like to see an answers list
" do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 5, question: question, author: user) }

  scenario 'User tries to view question answers' do
    visit question_path(question)

    expect(page).to have_table('Answers', with_cols: [answers.map(&:body)])
  end
end
