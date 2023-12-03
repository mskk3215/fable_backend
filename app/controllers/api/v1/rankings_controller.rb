# frozen_string_literal: true

class Api::V1::RankingsController < ApplicationController
  include StatisticsQueryConcern
  def index
    build_search_query

    # 特定地域のユーザー毎の総採集昆虫種類数を取得して、降順に並べる
    @insect_count_by_users = @insect_data
                             .group('users.id')
                             .select('users.id, users.nickname, COUNT(DISTINCT insects.id) as total_insect_count')
                             .order('total_insect_count DESC')
                             .limit(100)
                             .map do |user|
      collection_rate = @insect_count.zero? ? 0 : (user.total_insect_count.to_f / @insect_count * 100).round(1)
      { user_id:user.id, name: user.nickname, collection_rate: }
    end
    render 'api/v1/rankings/index'
  end
end
