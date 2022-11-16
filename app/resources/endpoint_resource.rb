# frozen_string_literal: true

class EndpointResource < JSONAPI::Resource
  attributes :verb, :path, :response
end
