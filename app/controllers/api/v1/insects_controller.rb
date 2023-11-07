# frozen_string_literal: true

module Api
  module V1
    class InsectsController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]

      def index
        if params[:status].present?

          insect_park_data = Insect.joins(images: [{ city: :prefecture }, :park, :user])
          insect_park_data = insect_park_data.where(prefectures: { name: params[:prefecture] }) if params[:prefecture].present?
          insect_park_data = insect_park_data.where(cities: { name: params[:city] }) if params[:city].present?

          # 採集済み, 未採集の昆虫データ取得処理
          case params[:status]
          when 'collected'
            insect_park_data = insect_park_data.where(users: { id: current_user.id })
          when 'uncollected'
            collected_insect_ids = insect_park_data.where(users: { id: current_user.id }).select(:insect_id)
            insect_park_data = insect_park_data.where.not(id: collected_insect_ids)
          end
          @insects = insect_park_data
                     .select('insects.*, parks.name AS park_name')
                     .group_by { |insect| [insect.name, insect.sex] }
                     .map do |(name, sex), insects|
            {
              name:,
              sex:,
              biological_family: insects.first.biological_family.name,
              park_name: insects.first.park_name
            }
          end

        else
          # 全ての昆虫データ取得処理
          all_insects = Insect.all
          @insects = all_insects.group_by(&:name).map do |name, insects|
            { name:, available_sexes: insects.map(&:sex) }
          end
        end

        render 'api/v1/insects/index'
      end
    end
  end
end
