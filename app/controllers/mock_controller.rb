# frozen_string_literal: true

class MockController < ApplicationController
  def mock
    endpoint = Endpoint.find_by!(verb: request.method, path: "/#{params[:mock]}")
    render json: mock_response(endpoint.response)
  rescue ActiveRecord::RecordNotFound
    render json: error_response
  end

  def mock_response(response)
    <<~HEREDOC
      > #{request.method} /#{params[:mock]} HTTP/1.1
      > Accept: application/json

      HTTP/1.1 #{response['code']} OK
      #{response['headers']}

      { #{response['body']} }
    HEREDOC
  end

  def error_response
    <<~HEREDOC
      > #{request.method} /#{params[:mock]} HTTP/1.1
      > Accept: application/json

        HTTP/1.1 404 Not found
        Content-Type: application/vnd.api+json

        {
            "errors": [
                {
                    "code": "not_found",
                    "detail": "Requested page `/#{params[:mock]}` does not exist"
                }
            ]
        }
    HEREDOC
  end
end
