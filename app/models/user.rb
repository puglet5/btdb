# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#
class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :password, confirmation: true
  validates :name, :email, presence: true

  has_settings do |s|
    s.key :uppy, defaults: { thumbnails: false }
  end

  has_many :experiments, dependent: :nullify
  has_many :samples, dependent: :nullify
  has_many :measurments, dependent: :nullify

  has_one_attached :avatar do |blob|
    blob.variant :small, resize: '50x50^', crop: '50x50+0+0', format: :jpg
    blob.variant :medium, resize: '100x100^', crop: '100x100+0+0', format: :jpg
  end

  def author?(obj)
    obj.user == self
  end
end
