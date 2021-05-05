# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Users::RegistrationsController < Devise::RegistrationsController
  
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end