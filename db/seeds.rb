# frozen_string_literal: true

require 'faker'
require 'database_cleaner/active_record'

DatabaseCleaner.clean_with(:truncation)

10.times do
  User.create!(name: Faker::Name.name,
               email: Faker::Internet.email,
               password: '123456')
end

admin = User.create!(name: 'Michael Basmanov',
                     email: 'test@test.test',
                     password: '123456')

admin.add_role(:admin)

users = User.all
users.each do |user|
  title = Faker::Lorem.sentence
  author = Faker::Name.name
  description = Faker::Lorem.paragraph
  status = Experiment.statuses.keys.sample
  category = Experiment.categories.keys.sample
  metadata = Faker::Json.shallow_json(width: 3,
                                      options: { key: 'Science.element',
                                                 value: 'Number.decimal(l_digits: 3, r_digits: 3)' })
  experiment = Experiment.create!(title: title, description: description, status: status, category: category, user_id: user.id, author: author)
  experiment.update!(metadata: metadata)

  title = Faker::Lorem.sentence
  description = Faker::Lorem.paragraph
  category = Sample.categories.keys.sample
  metadata = Faker::Json.shallow_json(width: 3,
                                      options: { key: 'Science.element',
                                                 value: 'Number.decimal(l_digits: 3, r_digits: 3)' })
  up = Sample.create!(title: title, description: description, category: category, user_id: user.id, experiment_ids: [[nil, Experiment.all.sample.id].sample])
  up.update!(metadata: metadata)

  title = Faker::Lorem.sentence
  equipment = Faker::Lorem.sentence
  date = Date.today - rand(10_000)
  category = Measurment.categories.keys.sample
  up = Measurment.create!(title: title, date: date, equipment: equipment, category: category, user_id: user.id, sample_id: Sample.all.sample.id)
end
