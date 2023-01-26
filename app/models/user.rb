# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string           indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string           default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include ProcessImage
  include ArTransactionChanges

  acts_as_favoritor

  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :password, confirmation: true
  validates :name, :email, presence: true

  has_settings do |s|
    s.key :uppy, defaults: { thumbnails: false }
    s.key :ui, defaults: { tooltips: true }
  end

  has_many :experiments, dependent: :nullify
  has_many :samples, dependent: :nullify
  has_many :measurements, dependent: :nullify

  # rubocop:disable Rails/InverseOf
  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all
  # rubocop:enable Rails/InverseOf

  has_one_attached :avatar do |blob|
    blob.variant :small, resize: '50x50^', crop: '50x50+0+0', format: :jpg
    blob.variant :medium, resize: '100x100^', crop: '100x100+0+0', format: :jpg
  end

  after_commit -> { process_image self, avatar&.id }, on: %i[create update], unless: -> { transaction_changed_attributes.keys == ['updated_at'] }

  def author?(obj)
    obj.user == self
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
