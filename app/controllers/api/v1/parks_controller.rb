# frozen_string_literal: true
module Api
  module V1
    class ParksController < ApplicationController
      def index
        parks = Park.all.order(created_at: :desc)
        render json: parks        
      end
    end
  end
end
