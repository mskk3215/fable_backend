# frozen_string_literal: true

class CollectedInsectForm
  include ActiveModel::Model

  attr_accessor :collected_insects, :collected_insect_params, :error_message, :current_user

  validate :validate_park_presence_with_city
  validate :validate_name_presence_with_sex

  def save
    if valid?
      ActiveRecord::Base.transaction do
        # insect, cityの事前呼び出し
        if collected_insect_params[:name].present?
          # collected_insectを作成するのにinsectが必要なので、insectが無ければ作成する。
          insect = Insect.find_or_create_by(name: collected_insect_params[:name])
        end
        city = City.find_by(name: collected_insect_params[:city_name]) if collected_insect_params[:city_name].present?
        park = Park.find_or_create_park(collected_insect_params[:park_name], city)

        collected_insects.each do |collected_insect|
          attributes = {
            sex: collected_insect_params[:sex].presence || collected_insect.sex,
            insect_id: insect&.id || collected_insect.insect_id,
            park_id: park&.id || collected_insect.park_id,
            city_id: city&.id || collected_insect.city_id,
            taken_date_time: collected_insect_params[:taken_date_time].presence || collected_insect.taken_date_time
          }
          # cityがあってparkがない場合はpark_idを削除する
          attributes[:park_id] = nil if city.present? && park.nil?
          collected_insect.update!(attributes)

          # 通知を作成
          collected_insect.create_sighting_notifications_if_recent_and_insect_changed(current_user)
        end
      end
      true
    else
      Rails.logger.debug errors.full_messages
      false
    end
  rescue StandardError => e
    Rails.logger.error "Unexpected error of type #{e.class} in CollectedInsectForm: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    self.error_message = e.message
    false
  end

  private

    def validate_park_presence_with_city
      return unless collected_insect_params[:park_name].present? && collected_insect_params[:city_name].blank?

      errors.add(:base, 'park_nameがある場合、city_nameも必須です')
    end

    def validate_name_presence_with_sex
      if collected_insect_params[:name].present? && collected_insect_params[:sex].blank?
        errors.add(:base, 'nameがある場合、sexも必須です')
      elsif collected_insect_params[:sex].present? && collected_insect_params[:name].blank?
        errors.add(:base, 'sexがある場合、nameも必須です')
      end
    end
end
