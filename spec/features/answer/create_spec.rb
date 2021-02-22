# frozen_string_literal: true

require 'rails_helper'

feature 'User can add an answer', "
  In order to help other people
  As an authenticated user
  I'd like to add an answer for a question
" do
  describe 'Authenticated user' do
    scenario 'adds an answer'
    scenario 'adds an answer with errors'
  end

  scenario 'Unauthenticated user tries to add an answer'
end
