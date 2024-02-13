# frozen_string_literal: true

class Api::V1::HealthController < ApplicationController
  skip_before_action :ensure_logged_in, only: [:index]

  def index
    ActiveRecord::Base.connection.execute('SELECT 1')
    render json: { status: 'ok' }, status: :ok
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :internal_server_error
  end
end
