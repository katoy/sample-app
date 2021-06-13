# frozen_string_literal: true

if Rails.application.credentials[:stripe]
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials[:stripe][:publishable_key],
    secret_key: Rails.application.credentials[:stripe][:secret_key]
  }
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
else
  Rails.configuration.stripe = {
    publishable_key: 'xxx',
    secret_key: 'xxx',
  }
  Stripe.api_key = 'xxx'
end