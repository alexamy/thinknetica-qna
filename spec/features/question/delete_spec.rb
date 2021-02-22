# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete question', "
  In order to remove undesired question
  As an authenticated user
  I'd like to be able to delete my own question
" do
  scenario 'Authenticated user deletes his question'
  scenario 'Authenticated user tries to delete others question'
  scenario 'Unauthenticated user tries to delete question'
end
