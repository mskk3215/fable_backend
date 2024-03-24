# frozen_string_literal: true

class ImageForm
  include ActiveModel::Model

  attr_accessor :images, :image_params

  validate :validate_park_presence_with_city
  validate :validate_name_presence_with_sex

  def save
    if valid?
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
          attributes[:park_id] = nil if city.present? && park.nil?
          image.update!(attributes)
        end
      end
      true
    else
      false
    end
  rescue StandardError => e
    Rails.logger.error "Unexpected error of type #{e.class} in ImageForm: #{e.message}"
    false
  end

  private

    def validate_park_presence_with_city
      return unless image_params[:park_name].present? && image_params[:city_name].blank?

      errors.add(:base, 'park_nameがある場合、city_nameも必須です')
    end

    def validate_name_presence_with_sex
      if image_params[:name].present? && image_params[:sex].blank?
        errors.add(:base, 'nameがある場合、sexも必須です')
      end
      return unless image_params[:sex].present? && image_params[:name].blank?

      errors.add(:base, 'sexがある場合、nameも必須です')
    end
end
