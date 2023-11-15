# frozen_string_literal: true

module StatisticsQueryConcern
  extend ActiveSupport::Concern

  included do
    def build_search_query
      insect_data = Insect.joins(images: [{ city: :prefecture }, :user])

      insect_data = insect_data.where(prefectures: { name: params[:prefecture_name] }) if params[:prefecture_name].present?
      insect_data = insect_data.where(cities: { name: params[:city_name] }) if params[:city_name].present?

      # 特定地域の昆虫種類数
      @insect_count = insect_data.distinct.count

      # 特定地域におけるログインユーザーの採集済み昆虫種類数
      if current_user
        user_insect_data = insect_data.where(images: { user_id: current_user.id })
        @collected_insect_count = user_insect_data.distinct.count
      end
      # insect_dataのインスタンスを作成
      @insect_data = insect_data
    end
  end
end
