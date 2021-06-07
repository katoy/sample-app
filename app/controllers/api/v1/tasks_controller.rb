# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApiController
      before_action :set_task, only: %i[show update destroy]
      skip_before_action :verify_authenticity_token

      def index
        # @tasks = Task.order(created_at: :DESC).preload(:users).paginate(page: params[:page])
        # render json: @tasks, meta: pagination(@tasks), adapter: :json
        @tasks = Task.order(created_at: :DESC).preload(:users)
        render json: @tasks, adapter: :json
      end

      def show
        render json: @task, adapter: :json
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task, adapter: :json, status: 201
        else
          render json: { errors: task.errors.full_messages }, status: 422
        end
      end

      def destroy
        @task.destroy
        render json: { message: 'Success delete' }, status: 200
      end

      def update
        if @task.update(task_params)
          render json: @task, adapter: :json, status: 200
        else
          render json: { errors: @task.errors.full_messages }, status: 422
        end
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:name, :status, user_ids: [])
      end
    end
  end
end
