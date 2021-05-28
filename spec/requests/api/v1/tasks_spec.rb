# frozen_string_literal: true

require 'rails_helper'

describe 'TaskAPI' do
  let!(:tasks) { create_list :task, 3, :with_two_users }

  describe 'get /api/v1/tasks' do
    it '全てのタスクを取得する' do
      get '/api/v1/tasks'
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(json['tasks'].length).to eq 3
      expect(json['tasks'][0]['users'].length).to eq 2
    end
  end

  describe 'get /api/v1/tasks/id' do
    it '特定のタスクを取得する' do
      get "/api/v1/tasks/#{tasks[0].id}"
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(json['task']['id']).to eq(tasks[0].id)
      expect(json['task']['name']).to eq(tasks[0].name)
      expect(json['task']['status']).to eq(tasks[0].status)
      expect(json['task']['users'].length).to eq 2
      expect(json['task']['users'][0]['email']).to eq tasks[0].users[1].email
    end
  end

  describe 'post /api/v1/tasks/id' do
    it 'タスクを登録する' do
      expect do
        params = { task: { name: 'xxx', status: false, user_ids: [User.order(:id).first.id] } }
        post '/api/v1/tasks', params: params
      end.to change { Task.count }.by(1)
      expect(response.status).to eq 201
    end
  end

  describe 'gut /api/v1/tasks/id' do
    it 'タスクを更新する' do
      expect do
        params = { task: { name: 'yyy', status: false, user_ids: [User.order(:id).last.id] } }
        put "/api/v1/tasks/#{tasks[0].id}", params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 200
      tasks[0].reload
      expect(tasks[0].name).to eq 'yyy'
      expect(tasks[0].status).to eq false
    end
  end

  describe 'get /api/v1/tasks/id' do
    it 'タスクを削除する' do
      expect do
        delete "/api/v1/tasks/#{tasks[0].id}"
      end.to change { Task.count }.by(-1)
      json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(json['msg']).to eq('Success delete')
    end
  end
end
