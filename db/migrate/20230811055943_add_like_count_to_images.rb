# frozen_string_literal: true

class AddLikeCountToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :likes_count, :integer, default: 0, null: false
  end
end
