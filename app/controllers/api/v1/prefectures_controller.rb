# frozen_string_literal: true

module Api
  module V1
    class PrefecturesController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]

      def index
        prefectures = Prefecture.includes(:cities).map do |prefecture|
          { name: prefecture.name, cities: prefecture.cities.map(&:name) }
        end
        render json: prefectures
      end
    end
  end
end
