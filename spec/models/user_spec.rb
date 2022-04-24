# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id(ID)                   :string(26)       not null, primary key
#  email                    :string(255)      default(""), not null
#  encrypted_password       :string(255)      default(""), not null
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string(255)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'association' do
    describe 'has_many tasks' do
      it { expect(User.reflect_on_association(:tasks).macro).to eq :has_many }
    end

    describe 'has_many connections' do
      it { expect(User.reflect_on_association(:connections).macro).to eq :has_many }
    end

    describe 'dependent: :destroy' do
      let!(:user) { create(:user, :with_two_tasks) }

      it { expect { user.destroy }.to change { Connection.count }.by(-2) }
      it { expect { user.destroy }.to change { Task.count }.by(0) }
    end
  end

  describe 'validats email' do
    subject { user.valid? }
    let(:user) { build :user, email: email }

    describe 'presense' do
      context 'email == ""' do
        let(:email) { '' }

        it do
          is_expected.to eq false
          expect(user.errors[:email]).to eq ['を入力してください']
        end
      end

      context 'email is "test@example.com"' do
        let(:email) { 'test@example.com' }

        it { is_expected.to eq true }
      end

      describe 'uniquness' do
        subject { user.valid? }
        let!(:user_one) { create(:user, email: 'test@example.com') }
        let(:user) { build(:user, email: email) }

        context 'same' do
          let(:email) { 'test@example.com' }

          it do
            is_expected.to eq false
            expect(user.errors[:nemail]).to eq []
            # expect(user.errors[:name]).to eq ["はすでに存在します"]
          end
        end

        context 'uppercase' do
          let(:email) { 'TEST@example.com' }

          it do
            is_expected.to eq false
            expect(user.errors[:nemail]).to eq []
            # expect(user.errors[:nemail]).to eq ["はすでに存在します"]
          end
        end
      end
    end
  end
end
