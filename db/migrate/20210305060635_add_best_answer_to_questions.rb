# frozen_string_literal: true

class AddBestAnswerToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :best_answer, null: true, foreign_key: { to_table: :answers }
  end
end
