# frozen_string_literal: true

require 'test_helper'

class MockControllerTest < ActionDispatch::IntegrationTest
  test 'client requests non-existing path' do
    get '/unknown'
    assert_response :success

    assert_match(%r{GET /unknown}, @response.body)
    assert_match(/404 Not found/, @response.body)
    assert_match(/not_found/, @response.body)
    assert_match(%r{Requested page `/unknown` does not exist}, @response.body)
  end

  test 'client requests existing endpoint' do
    FactoryBot.create(:endpoint, path: '/hello', response: {
                        code: 200,
                        headers: { "Content-Type": 'application/json' },
                        body: { "message": 'Hello, world' }
                      })

    get '/hello'
    assert_response :success

    assert_match(%r{GET /hello}, @response.body)
    assert_match(/200 OK/, @response.body)
    assert_match(%r{application/json}, @response.body)
    assert_match(/"Hello, world"/, @response.body)
  end

  test 'client requests existing endpoint, with different HTTP verb' do
    FactoryBot.create(:endpoint, path: '/hello')

    post '/hello'
    assert_response :success

    assert_match(%r{POST /hello}, @response.body)
    assert_match(/404 Not found/, @response.body)
    assert_match(/not_found/, @response.body)
    assert_match(%r{Requested page `/hello` does not exist}, @response.body)
  end

  test 'works with GET, POST, PUT, PATCH, and DELETE verbs' do
    FactoryBot.create(:endpoint, path: '/hello')
    FactoryBot.create(:endpoint, path: '/hello', verb: 'POST')
    FactoryBot.create(:endpoint, path: '/hello', verb: 'PUT')
    FactoryBot.create(:endpoint, path: '/hello', verb: 'PATCH')
    FactoryBot.create(:endpoint, path: '/hello', verb: 'DELETE')

    get '/hello'
    assert_response :success

    post '/hello'
    assert_response :success

    put '/hello'
    assert_response :success

    patch '/hello'
    assert_response :success

    delete '/hello'
    assert_response :success
  end
end
