# frozen_string_literal: true

module ErrorRenderable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render json: {
        errors: {
          title: 'レコードが見つかりません',
          detail: "ID と一致する #{exception.model} レコードが見つかりません"
        }
      }, status: :not_found
    end

    rescue_from ::ActionController::RoutingError do |exception|
      render json: {
        errors: {
          ttle: 'RoutingError', detail: exception.message
        }
      }, status: :not_found
    end
  end
end
