# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class TenantController < ApplicationController
  before_action :authenticate_user!
  
  def update
    current_user.update!(tenant_params)
    redirect_to root_path, notice: "You are now in the account #{current_user.tenant}"
  end

  def tenant_params
    params.require(:user).permit(:tenant)
  end

end
