# frozen_string_literal: true

class ImageForm
  include ActiveModel::Model

  attr_accessor :images, :image_params

  def save
    ActiveRecord::Base.transaction do
      # insect, cityの事前呼び出し
      insect = Insect.find_by(name: image_params[:name], sex: image_params[:sex]) if image_params[:name].present?
      city = City.find_by(name: image_params[:city_name]) if image_params[:city_name].present?
      park = Park.find_or_create_park(image_params[:park_name], city)
      images.each do |image|
        attributes = {
          insect_id: insect&.id || image.insect_id,
          park_id: park&.id || image.park_id,
          city_id: city&.id || image.city_id,
          taken_at: image_params[:taken_at].presence || image.taken_at
        }
        # cityがあってparkがない場合はpark_idを削除する
        attributes[:park_id] = nil if city.present? && park.new_record?
        image.update!(attributes)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
