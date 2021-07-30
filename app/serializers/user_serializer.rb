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
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :tasks
end
