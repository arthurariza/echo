# frozen_string_literal: true

class MockController < ApplicationController
  def mock
    endpoint = Endpoint.find_by!(verb: request.method, path: "/#{params[:mock]}")
    render json: mock_response(request.method, params[:mock], endpoint.response)
  rescue ActiveRecord::RecordNotFound
    render json: error_response
  end

  def mock_response(http_method, path, response)
    <<~HEREDOC
      > #{http_method} /#{path} HTTP/1.1
      > Accept: application/json

      HTTP/1.1 #{response} OK
      #{response}

      { #{response} }
    HEREDOC
  end

  def error_response
    <<~HEREDOC
      HTTP/1.1 404 Not found
      Content-Type: application/vnd.api+json

      {
          "errors": [
              {
                  "code": "not_found",
                  "detail": "Requested Endpoint with ID `#{params[:mock]}` does not exist"
              }
          ]
      }
    HEREDOC
  end
end
