# frozen_string_literal: true

module Api
  module V1
    class InsectsController < ApplicationController
      def index
        insects = Insect.all.order(created_at: :desc)
        render json: insects
      end
    end
  end
end
