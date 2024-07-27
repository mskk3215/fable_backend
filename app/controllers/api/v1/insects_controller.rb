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

      def show
        @insect = Insect.includes(:biological_family, :habitat_place, :tools, :foods, :collected_insects).find(params[:id])
        @taken_amount_per_month = @insect.taken_amount_per_month
        @taken_amount_per_hour = @insect.taken_amount_per_hour
        @total_insects_count = @insect.collected_insects.count
        @is_collected = @insect.collected_insects.any? { |ci| ci.user_id == current_user.id }

        render 'api/v1/insects/show'
      end

      private

        # 初期データの取得
        def initialize_insect_park_data
          insect_park_data = Insect.joins(collected_insects: [{ city: :prefecture }, :park, :user]).order(:id)
          insect_park_data = insect_park_data.joins(collected_insects: :collected_insect_image)

          Rails.logger.debug { "Insect Park Data: #{insect_park_data.inspect}" }

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
          collected_insects = insect_park_data.where(collected_insects: { user_id: current_user.id })

          collected_insects.select('insects.*, parks.name AS park_name')
                           .group_by(&:name)
                           .map do |name, insects|
            # park_name が存在する最初の collected_insect オブジェクトを取得する
            collected_insect_with_park_name = insects.find { |insect|
                                                insect.collected_insects.any? do |ci|
                                                  ci.park&.name.present?
                                                end
                                              }&.collected_insects&.first
            {
              id: insects.first.id,
              name:,
              biological_family: insects.first.biological_family.name,
              park_name: collected_insect_with_park_name&.park&.name || nil
            }
          end
        end

        # 未採集の昆虫と公園のリスト
        def fetch_uncollected_insects(insect_park_data)
          collected_insect_ids = insect_park_data.where(collected_insects: { user_id: current_user.id }).pluck(:insect_id)
          uncollected_insect_park_data = insect_park_data.where.not(id: collected_insect_ids).distinct

          Rails.logger.debug { "Uncollected Insect Park Data: #{uncollected_insect_park_data.inspect}" }

          if params[:lat].present? && params[:lng].present?
            nearest_parks = Park.near([params[:lat], params[:lng]], 2000, units: :km).order(:distance)
            uncollected_insect_park_data.map do |insect|
              # 過去に投稿された昆虫かつ、指定された市町村に存在する公園の中から最も近い公園を取得
              found_in_park = nearest_parks.detect do |park|
                park.collected_insects.any? do |collected_insect|
                  collected_insect.insect_id == insect.id
                end && (params[:city].blank? || park.city.name == params[:city]) && (params[:prefecture].blank? || park.city.prefecture.name == params[:prefecture])
              end
              {
                id: insect.id,
                name: insect.name,
                biological_family: insect.biological_family.name,
                park_name: found_in_park&.name || nil
              }
            end
          else
            uncollected_insect_park_data
              .select('insects.*, parks.name AS park_name')
              .group_by(&:name)
              .map do |name, insects|
              {
                id: insects.first.id,
                name:,
                biological_family: insects.first.biological_family.name,
                park_name: insects.first.park_name
              }
            end
          end
        end

        # autocomplete用の昆虫のリスト
        def fetch_insect_data
          all_insects = params[:query_word].present? ? Insect.where('name LIKE ?', "%#{params[:query_word]}%").limit(20) : []

          all_insects.map do |insect|
            { name: insect.name }
          end
        end
    end
  end
end
