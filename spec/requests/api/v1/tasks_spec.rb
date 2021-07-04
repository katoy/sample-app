# frozen_string_literal: true

require 'rails_helper'

describe 'TaskAPI' do
  let(:tasks_size) { 3 }
  let!(:tasks) { create_list :task, tasks_size, :with_two_users }
  let(:json) { JSON.parse(response.body) }
  let(:expect_json_notfound) do
    {
      'title' => 'レコードが見つかりません',
      'detail' => 'ID と一致する Task レコードが見つかりません',
    }
  end
  let(:expect_json_notfound_user) do
    {
      'title' => 'レコードが見つかりません',
      'detail' => 'ID と一致する User レコードが見つかりません'
    }
  end
  let(:expect_invalid_name) do
    ['Nameを入力してください', 'Nameは1文字以上で入力してください']
  end

  describe 'get /api/v1/tasks' do
    it '全てのタスクの取得が正常終了' do
      get '/api/v1/tasks'
      expect(response.status).to eq 200
      expect(json['tasks'].length).to eq tasks_size
      expect(json['tasks'][0]['users'].length).to eq 2
    end
  end

  describe 'get /api/v1/tasks/id' do
    it '特定のタスクの取得が正常終了' do
      get "/api/v1/tasks/#{tasks[0].id}"
      expect(response.status).to eq 200
      expect(json['task']['id']).to eq(tasks[0].id)
      expect(json['task']['name']).to eq(tasks[0].name)
      expect(json['task']['status']).to eq(tasks[0].status)
      expect(json['task']['users'].length).to eq 2
      expect(json['task']['users'][0]['email']).to eq tasks[0].users[1].email
    end

    it '存在しないタスク id を指定した場合' do
      no_exist_id = Task.order(:id).last.id + 1
      get "/api/v1/tasks/#{no_exist_id}"
      expect(response.status).to eq 404
      expect(json['errors']).to eq expect_json_notfound
    end
  end

  describe 'post /api/v1/tasks/id' do
    it 'タスクの登録が正常終了' do
      expect do
        params = { task: { name: 'xxx', status: false, user_ids: [User.order(:id).first.id] } }
        post '/api/v1/tasks', params: params
      end.to change { Task.count }.by(1)
      expect(response.status).to eq 201
      user = User.order(:id).first
      expect(json).to eq(
        {
          'task' => {
            'id' => Task.order(:id).last.id, 'name' => 'xxx', 'status' => false,
            'users' => [{ 'id' => user.id, 'email' => user.email }]
          }
        }
      )
    end

    it '不正な params (name is empty) を指定した場合' do
      expect do
        params = { task: { name: '', status: false, user_ids: [User.order(:id).first.id] } }
        post '/api/v1/tasks', params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 422
      expect(json['errors']).to eq expect_invalid_name
    end

    it '不正な params (no-exist user)　を指定した場合' do
      expect do
        params = { task: { name: '', status: false, user_ids: [User.order(:id).last.id + 1] } }
        post '/api/v1/tasks', params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 404
      expect(json['errors']).to eq expect_json_notfound_user
    end
  end

  describe 'gut /api/v1/tasks/id' do
    let(:params) { { task: { name: 'yyy', status: false, user_ids: [User.order(:id).last.id] } } }

    it 'タスクの更新が正常終了' do
      expect do
        put "/api/v1/tasks/#{tasks[0].id}", params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 200
      tasks[0].reload
      expect(tasks[0].name).to eq 'yyy'
      expect(tasks[0].status).to eq false
    end

    it '存在しないタスク id を指定した場合' do
      no_exist_id = Task.order(:id).last.id + 1
      expect do
        put "/api/v1/tasks/#{no_exist_id}", params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 404
      expect(json['errors']).to eq expect_json_notfound
    end

    it 'name に空を指定した場合' do
      params[:task][:name] = ''
      expect do
        put "/api/v1/tasks/#{tasks[0].id}", params: params
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 422
      expect(json['errors']).to eq expect_invalid_name
    end
  end

  describe 'get /api/v1/tasks/id' do
    it 'タスクを削除が正常終了' do
      expect do
        delete "/api/v1/tasks/#{tasks[0].id}"
      end.to change { Task.count }.by(-1)
      expect(response.status).to eq 200
      expect(json['message']).to eq('Success delete')
    end

    it '存在しないタスク id を指定した場合' do
      no_exist_id = Task.order(:id).last.id + 1
      expect do
        delete "/api/v1/tasks/#{no_exist_id}"
      end.to change { Task.count }.by(0)
      expect(response.status).to eq 404
      expect(json['errors']).to eq expect_json_notfound
    end
  end
end
