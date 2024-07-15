# frozen_string_literal: true

module Api
  module V1
    class ParksController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]

      def index
        @parks = Park.includes(:prefecture, :city, :collected_insect_images).order(created_at: :asc)
        if insect_name = params[:search_word]
          @parks = @parks.joins(collected_insect_images: :insect).where('insects.name = ?', insect_name).distinct
        end
        render 'api/v1/parks/index'
      end
    end
  end
end
