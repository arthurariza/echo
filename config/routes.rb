# frozen_string_literal: true

Rails.application.routes.draw do
  jsonapi_resources :endpoints

  get '/:mock', to: 'mock#mock'
  post '/:mock', to: 'mock#mock'
  patch '/:mock', to: 'mock#mock'
  put '/:mock', to: 'mock#mock'
  delete '/:mock', to: 'mock#mock'
end
