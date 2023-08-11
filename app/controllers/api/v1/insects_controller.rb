# frozen_string_literal: true

module Api
  module V1
    class InsectsController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]

      def index
        all_insects = Insect.all
        insects = all_insects.group_by(&:name).map do |name, sex|
          { name:, availableSexes: sex.map(&:sex) }
        end
        render json: insects
      end
    end
  end
end
