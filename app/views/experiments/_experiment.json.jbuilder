# frozen_string_literal: true

json.extract! experiment, :id, :title, :author, :staff, :type, :status, :created_at, :updated_at
json.url experiment_url(experiment, format: :json)
