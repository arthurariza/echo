# frozen_string_literal: true

require 'test_helper'

class EndpointTest < ActiveSupport::TestCase
  context 'validations' do
    subject { FactoryBot.build(:endpoint) }

    should validate_presence_of(:verb)
    should validate_presence_of(:path)
    should validate_uniqueness_of(:path).scoped_to(:verb)
  end

  test 'Response code is required' do
    endpoint = FactoryBot.build(:endpoint, response: {})

    assert endpoint.invalid?
    assert endpoint.errors[:response].any?
    assert_equal ['Response code is required'], endpoint.errors[:response]

    endpoint['response'] = { code: 200 }
    assert endpoint.valid?
  end
end
