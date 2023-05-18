# frozen_string_literal: true

module Api
  module V1
    class PrefecturesController < ApplicationController
      def index
        all_cities = City.all
        prefectures = all_cities.group_by(&:prefecture_id).map do |prefecture_id, cities|
          prefecture = Prefecture.find(prefecture_id)
          { name: prefecture.name, cities: cities.map(&:name) }
        end
        render json: prefectures
      end
    end
  end
end
