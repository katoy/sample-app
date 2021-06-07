# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: %i[show update destroy]
      skip_before_action :verify_authenticity_token

      def index
        @users = User.order(created_at: :DESC).preload(:tasks)
        render json: @users, adapter: :json
      end

      def show
        render json: user, adapter: :json
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, adapter: :json, status: 201
        else
          render json: { error: user.errors }, status: 422
        end
      end

      def destroy
        @user.destroy
        # render json: { status: 'SUCCESS', message: 'Deleted the task', data: @task }
        render json: { msg: 'Success delete' }, status: 200
      end

      def update
        if @user.update(user_params)
          render json: @user, adapter: :json, status: 200
        else
          render json: { error: @user.errors }, status: 422
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, email, task_ids: [])
      end
    end
  end
end
