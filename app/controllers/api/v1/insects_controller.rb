# frozen_string_literal: true

module Api
  module V1
    class InsectsController < ApplicationController
      skip_before_action :ensure_logged_in, only: %i[index]

      def index
        @insects = if params[:status].present?
                     insect_park_data = initialize_insect_park_data

                     case params[:status]
                     when 'collected'
                       fetch_collected_insects(insect_park_data)
                     when 'uncollected'
                       fetch_uncollected_insects(insect_park_data)
                     end

                   else
                     fetch_insect_data
                   end

        render 'api/v1/insects/index'
      end

      private

        # 初期データの取得
        def initialize_insect_park_data
          insect_park_data = Insect.joins(images: [{ city: :prefecture }, :park, :user])

          if params[:prefecture].present?
            insect_park_data = insect_park_data.where(prefectures: { name: params[:prefecture] })
          end

          if params[:city].present?
            insect_park_data = insect_park_data.where(cities: { name: params[:city] })
          end

          insect_park_data
        end

        # 採集済みの昆虫と公園のリスト
        def fetch_collected_insects(insect_park_data)
          collected_insects = insect_park_data.where(images: { user_id: current_user.id })

          collected_insects.select('insects.*, parks.name AS park_name')
                           .group_by { |insect| [insect.name, insect.sex] }
                           .map do |(name, sex), insects|
            {
              id: insects.first.id,
              name:,
              sex:,
              biological_family: insects.first.biological_family.name,
              park_name: insects.first.park_name
            }
          end
        end

        # 未採集の昆虫と公園のリスト
        def fetch_uncollected_insects(insect_park_data)
          collected_insect_ids = insect_park_data.where(images: { user_id: current_user.id }).select(:insect_id)
          uncollected_insect_park_data = insect_park_data.where.not(id: collected_insect_ids).distinct

          if params[:lat].present? && params[:lng].present?
            nearest_parks = Park.near([params[:lat], params[:lng]], 2000, units: :km).order(:distance)

            uncollected_insect_park_data.map do |insect|
              found_in_park = nearest_parks.detect do |park|
                park.images.any? do |image|
                  image.insect_id == insect.id
                end && (params[:city].blank? || park.city.name == params[:city]) && (params[:prefecture].blank? || park.city.prefecture.name == params[:prefecture])
              end
              {
                id: insect.id,
                name: insect.name,
                sex: insect.sex,
                biological_family: insect.biological_family.name,
                park_name: found_in_park&.name || nil
              }
            end
          else
            uncollected_insect_park_data
              .select('insects.*, parks.name AS park_name')
              .group_by { |insect| [insect.name, insect.sex] }
              .map do |(name, sex), insects|
              {
                id: insects.first.id,
                name:,
                sex:,
                biological_family: insects.first.biological_family.name,
                park_name: insects.first.park_name
              }
            end
          end
        end

        # autocomplete用の昆虫のリスト
        def fetch_insect_data
          all_insects = params[:query_word].present? ? Insect.where('name LIKE ?', "%#{params[:query_word]}%").limit(20) : []

          Array(all_insects).group_by(&:name).map do |name, insects|
            { name:, available_sexes: insects.map(&:sex) }
          end
        end
    end
  end
end
