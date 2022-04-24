# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id(ID)       :string(26)       not null, primary key
#  name         :string(255)      not null
#  status       :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_tasks_on_name    (name) UNIQUE
#  index_tasks_on_status  (status)
#
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'association' do
    describe 'has_many users' do
      it { expect(Task.reflect_on_association(:users).macro).to eq :has_many }
    end

    describe 'has_many connections' do
      it { expect(Task.reflect_on_association(:connections).macro).to eq :has_many }
    end

    describe 'dependent: :destroy' do
      let!(:task) { create(:task, :with_two_users) }

      it { expect { task.destroy }.to change { Connection.count }.by(-2) }
      it { expect { task.destroy }.to change { User.count }.by(0) }
    end
  end

  describe 'validats name' do
    subject { task.valid? }
    let(:task) { build :task, name: name }

    describe 'presense' do
      context 'name == ""' do
        let(:name) { '' }

        it do
          is_expected.to eq false
          expect(task.errors[:name]).to eq %w[を入力してください は1文字以上で入力してください]
        end
      end

      context 'name is "x"' do
        let(:name) { 'x' * 100 }

        it { is_expected.to eq true }
      end

      context 'name is "x" * 100' do
        let(:name) { 'x' * 100 }

        it { is_expected.to eq true }
      end

      context 'name is "x" : 101' do
        let(:name) { 'x' * 101 }

        it do
          is_expected.to eq false
          expect(task.errors[:name]).to eq ['は100文字以内で入力してください']
        end
      end
    end

    describe 'uniquness' do
      subject { task.valid? }
      let!(:task_one) { create(:task, name: 'a') }
      let(:task) { build(:task, name: name) }

      context 'same' do
        let(:name) { 'a' }

        it do
          is_expected.to eq false
          expect(task.errors[:name]).to eq ['はすでに存在します']
        end
      end

      context 'uppercase' do
        let(:name) { 'A' }

        it { is_expected.to eq true }
      end
    end
  end
end
