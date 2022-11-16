# frozen_string_literal: true

FactoryBot.define do
  factory :endpoint do
    verb { 'MyString' }
    path { 'MyString' }
    response { 'MyText' }
  end
end
