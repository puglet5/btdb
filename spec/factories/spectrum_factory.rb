# frozen_string_literal: true

# == Schema Information
#
# Table name: spectra
#
#  category           :integer
#  created_at         :datetime         not null
#  filename           :string
#  format             :integer          default("not_set"), not null
#  id                 :bigint           not null, primary key
#  is_reference       :boolean          default(FALSE), not null
#  measurement_id     :bigint           not null, indexed
#  metadata           :jsonb            not null, indexed
#  processing_message :text
#  sample_thickness   :float
#  status             :integer          default("none"), not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null, indexed
#
# Indexes
#
#  index_spectra_on_measurement_id  (measurement_id)
#  index_spectra_on_metadata        (metadata) USING gin
#  index_spectra_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_7788863ffe  (measurement_id => measurements.id)
#
FactoryBot.define do
  factory :spectrum do
    association :measurement, factory: :measurement, strategy: :build
    association :user, factory: :user, strategy: :build
    metadata { '{"test_key": "test_value"}' }

    trait :with_file do
      transient do
        file { 'test.csv' }
      end
      after(:build) do |s, e|
        blob = ActiveStorage::Blob.create_and_upload!(io: Rails.root.join("spec/fixtures/files/spectra/#{e.file}").open, filename: e.file, content_type: 'text/*', metadata: nil)
        s.file.attach(blob)
      end
    end
  end
end
