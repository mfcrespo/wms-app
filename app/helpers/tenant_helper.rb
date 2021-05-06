# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

module TenantHelper
  
  def current_account_name
    concat ActsAsTenant.current_tenant.name + " (Admin)" if current_user.is_admin?
    ActsAsTenant.current_tenant.name + " (User)" unless current_user.is_admin?
  end
  
  def list_tenants_helper(current_user)
    form_with model: current_user,  url: tenants_path,  method: :put do |form|
      concat form.select :tenant, current_user.guest_list
      concat form.submit("Change Account", class: "btn1")
    end
  end

  
end