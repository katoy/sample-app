# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                        :bigint           not null, primary key
#  consumed_timestep         :integer
#  email                     :string(255)      default(""), not null
#  encrypted_otp_secret      :string(255)
#  encrypted_otp_secret_iv   :string(255)
#  encrypted_otp_secret_salt :string(255)
#  encrypted_password        :string(255)      default(""), not null
#  otp_backup_codes          :text(65535)
#  otp_required_for_login    :boolean
#  remember_created_at       :datetime
#  reset_password_sent_at    :datetime
#  reset_password_token      :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  devise :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['SECRET_ENCRYPTION_KEY']

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :two_factor_backupable, otp_number_of_backup_codes: 10
  serialize :otp_backup_codes, JSON

  has_many :connections, dependent: :destroy
  has_many :tasks, -> { order(id: :DESC) }, through: :connections
  validates :email,
            presence: true, uniqueness: { case_sensitive: false }
end
