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
            insect_park_data = insect_park_data.where(images: { user_id: current_user.id })

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

          when 'uncollected'
            # 採集済みの昆虫idを取得
            collected_insect_ids = insect_park_data.where(images: { user_id: current_user.id }).select(:insect_id)
            # 採集済みの昆虫データを除外
            uncollected_insect_park_data = insect_park_data.where.not(id: collected_insect_ids).distinct
            # 現在位置がある場合は、最寄りのParkを検索して、そのParkの昆虫データを返す
            @insects = if params[:lat].present? && params[:lng].present?
                         nearest_parks = Park.near([params[:lat], params[:lng]], 2000, units: :km).order(:distance)
                         uncollected_insect_park_data.map do |insect|
                           found_in_park = nearest_parks.detect do |park|
                             park.images.any? do |image|
                               image.insect_id == insect.id
                             end
                           end
                           {
                             name: insect.name,
                             sex: insect.sex,
                             biological_family: insect.biological_family.name,
                             park_name: found_in_park&.name || nil
                           }
                         end
                       else
                        # 現在位置がない場合,公園名は最初に取得したものを返す
                         uncollected_insect_park_data
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
                       end
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
