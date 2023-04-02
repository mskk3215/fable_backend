# frozen_string_literal: true

module Api
  module V1
    class ParksController < ApplicationController
      def index
        if params[:search_word].present?
          insect_name = params[:search_word]
          parks = Park.joins(images: :insect).where('insects.name = ?', insect_name).distinct
        else
          parks = Park.all.order(created_at: :desc)
        end
        render json: parks
      end
    end
  end
end
