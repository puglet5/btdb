# frozen_string_literal: true

json.array! @experiments, partial: 'experiments/experiment', as: :experiment
