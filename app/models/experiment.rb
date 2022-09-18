# frozen_string_literal: true

# == Schema Information
#
# Table name: experiments
#
#  id         :bigint           not null, primary key
#  title      :string           default(""), not null
#  author     :string           default(""), not null
#  staff      :string           default(""), not null
#  category   :integer          default("undef")
#  status     :integer          default("undef")
#  open_date  :date
#  close_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
class Experiment < ApplicationRecord
  belongs_to :user
  validates :title, :author, presence: true

  enum status: { undef: 0, ongoing: 1, cancelled: 2, finished: 3 }

  enum category: { undef: 0 }, _suffix: :category
end
