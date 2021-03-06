# frozen_string_literal: true

require 'rails_helper'

feature 'User can choose the best answer', "
  In order to mark the most useful answer
  As an author of question
  I'd like to choose the best answer
" do
  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 4, question: question, author: user) }

  background { sign_in(user) }

  scenario 'Authenticated user set answer as the best', js: true do
    visit question_path(question)

    answers.each do |best_answer|
      best_answer_selector = "#answer-#{best_answer.id}"
      answers_reordered = [best_answer] + answers.reject { |a| a == best_answer }

      within(best_answer_selector) { click_on 'Choose as best' }

      answers_bodies = page.all('.answers .answer-body').map(&:text)

      within best_answer_selector do
        expect(page).to have_no_content 'Choose as best'
      end

      expect(page).to have_selector "#{best_answer_selector}.best-answer"
      expect(page).to have_selector '.best-answer', count: 1
      expect(answers_bodies).to eq answers_reordered.map(&:body)
    end
  end
end
