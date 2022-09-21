# frozen_string_literal: true

json.extract! sample, :id, :title, :category, :created_at, :updated_at
json.url sample_url(sample, format: :json)
