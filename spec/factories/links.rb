# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    name { 'my gist' }
    url { 'https://gist.github.com/alexamy/259aeed922d066ca09510fd18de20f80' }
  end
end
