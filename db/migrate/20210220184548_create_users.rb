# frozen_string_literal: true

# rubocop:disable all
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|

      t.timestamps
    end
  end
end
# rubocop:enable all
