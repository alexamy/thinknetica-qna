# frozen_string_literal: true

require 'rails_helper'

feature 'User can view question list', "
  In order to find desired question
  As an user
  I'd like to be able to see all questions
" do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 5, author: user) }

  scenario 'User views a questions list' do
    visit questions_path

    expect(page.all('.question').map(&:text)).to contain_exactly(*questions.map(&:title))
  end
end
