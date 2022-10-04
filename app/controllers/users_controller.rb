# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def update_settings
    return unless setting_params

    @user = current_user

    setting_params[:settings].each do |key, value|
      case key
      when 'uppy'
        value['thumbnails'] = ActiveModel::Type::Boolean.new.cast(value['thumbnails'])
      when 'ui'
        value['tooltips'] = ActiveModel::Type::Boolean.new.cast(value['tooltips'])
      end

      @user.settings(key.to_sym).update! value
    end
    redirect_to @user
    flash[:success] = 'Settings updated!'
  end

  def setting_params
    params.require(:user).permit(settings:
                                  {
                                    uppy: :thumbnails,
                                    ui: :tooltips
                                  })
  end
end
