# frozen_string_literal: true

module Api
  module V1
    module Users
      class RelationshipsController < ApplicationController
        before_action :set_user, only: %i[create destroy]

        def create
          current_user.following << @user
          render 'api/v1/users/relationships/create'
        rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => e
          render json: { error: e.message },
                 status: :unprocessable_entity
        end

        def destroy
          current_user.following.delete(@user)
          render 'api/v1/users/relationships/destroy'
        rescue ActiveRecord::RecordNotDestroyed => e
          render json: { error: e.message },
                 status: :unprocessable_entity
        end

        private

          def set_user
            @user = User.find(params[:id])
          end
      end
    end
  end
end
