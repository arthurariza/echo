# frozen_string_literal: true

class ChangeResponseToJson < ActiveRecord::Migration[7.0]
  def change
    change_column :endpoints, :response, :jsonb, using: 'response::jsonb'
  end
end
