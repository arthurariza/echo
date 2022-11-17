# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :endpoints

  get '/:mock', to: 'mock#mock'
end
