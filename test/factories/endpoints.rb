# frozen_string_literal: true

FactoryBot.define do
  factory :endpoint do
    verb { 'GET' }
    path { '/test' }
    response do
      {
        'code' => 200
      }
    end
  end
end
