# frozen_string_literal: true

if Rails.env.test?
  Rails.configuration.stripe = {
      :publishable_key => 'pk_test_xxxxxxxxxxxxxxxxxxxxxxxxxx',
      :secret_key      => 'sk_test_xxxxxxxxxxxxxxxxxxxxxxxxxx'
  }
else
  Rails.configuration.stripe = {
    publishable_key: Rails.application.credentials[:stripe][:publishable_key],
    secret_key: Rails.application.credentials[:stripe][:secret_key]
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
