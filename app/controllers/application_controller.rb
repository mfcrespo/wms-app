# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :set_current_account

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :account_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:account_id] )
  end

  private

  def set_current_account
    return unless current_user.present?
    current_account_name = current_user.tenant || current_user.guest_list.first
    ActsAsTenant.current_tenant = Account.find_by(name: current_account_name)
  end

end
