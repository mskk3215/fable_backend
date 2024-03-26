# frozen_string_literal: true

class Api::V1::Users::StatisticsController < ApplicationController
  include StatisticsQueryConcern

  def index
    build_search_query
    # 未採集昆虫種類数
    @uncollected_insect_count = @insect_count - @collected_insect_count
    # 採集率
    @collection_rate = @insect_count.zero? ? 0 : (@collected_insect_count.to_f / @insect_count * 100).round(1)

    render 'api/v1/users/statistics/index'
  end
end
