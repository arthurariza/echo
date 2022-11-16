# frozen_string_literal: true

class Endpoint < ApplicationRecord
  validates :verb, :path, :response, presence: true
  validates :path, uniqueness: { scope: :verb }
  validates :verb, inclusion: { in: %w[GET POST PUT PATCH DELETE],
                                message: '%<value>s is not a valid http verb' }
  validate :response_code_is_required

  def response_code_is_required
    errors.add(:response, 'Response code is required') unless response.match(/code/)
  end
end
