# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_811_055_943) do
  create_table 'cities', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'prefecture_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['prefecture_id'], name: 'index_cities_on_prefecture_id'
  end

  create_table 'images', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'image', null: false
    t.datetime 'taken_at'
    t.bigint 'user_id', null: false
    t.bigint 'insect_id'
    t.bigint 'park_id'
    t.bigint 'city_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'likes_count', default: 0, null: false
    t.index ['city_id'], name: 'index_images_on_city_id'
    t.index ['insect_id'], name: 'index_images_on_insect_id'
    t.index ['park_id'], name: 'index_images_on_park_id'
    t.index ['user_id'], name: 'index_images_on_user_id'
  end

  create_table 'insect_parks', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'insect_id', null: false
    t.bigint 'park_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['insect_id'], name: 'index_insect_parks_on_insect_id'
    t.index ['park_id'], name: 'index_insect_parks_on_park_id'
  end

  create_table 'insects', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'sex', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'likes', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'image_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['image_id'], name: 'index_likes_on_image_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'parks', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'post_code'
    t.string 'address'
    t.float 'latitude'
    t.float 'longitude'
    t.bigint 'city_id', null: false
    t.bigint 'prefecture_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['city_id'], name: 'index_parks_on_city_id'
    t.index ['prefecture_id'], name: 'index_parks_on_prefecture_id'
  end

  create_table 'prefectures', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'relationships', charset: 'utf8mb3', force: :cascade do |t|
    t.integer 'follower_id', null: false
    t.integer 'followed_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index %w[follower_id followed_id], name: 'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'users', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'nickname', null: false
    t.string 'email', null: false
    t.string 'password_digest', null: false
    t.string 'avatar'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'cities', 'prefectures'
  add_foreign_key 'images', 'cities'
  add_foreign_key 'images', 'insects'
  add_foreign_key 'images', 'parks'
  add_foreign_key 'images', 'users'
  add_foreign_key 'insect_parks', 'insects'
  add_foreign_key 'insect_parks', 'parks'
  add_foreign_key 'likes', 'images'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'parks', 'cities'
  add_foreign_key 'parks', 'prefectures'
end
