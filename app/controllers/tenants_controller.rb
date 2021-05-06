# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class TenantsController < ApplicationController
  before_action :authenticate_user!
  
  def update
    if ActsAsTenant.current_tenant.name !=  params[:user][:tenant]
      current_user.update!(tenant_params)
      redirect_to root_path, notice: "You are now in the account #{current_user.tenant}"
    else
      redirect_to root_path, notice: "You are already in the account #{current_user.tenant}"
    end
  end

  def tenant_params
    params.require(:user).permit(:tenant)
  end

end
