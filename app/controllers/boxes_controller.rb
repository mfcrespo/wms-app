# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class BoxesController < ApplicationController
  set_current_tenant_through_filter
  before_action :authenticate_user!
  before_action :set_tenant, only: :show

  def index
    @boxes = Box.all
  end

  def show
    @box = Box.find(params[:id])
    @items = @box.items
  end

  def new
    @box = ActsAsTenant.current_tenant.boxes.new
    @box.items.build
  end

  def create
    @box = ActsAsTenant.current_tenant.boxes.new(box_params)
    @box.user = current_user
    if @box.save
      @box.add_qr_code(request.base_url + box_path(@box))
      redirect_to root_path, notice: 'Box succesfully created'
    else
      render :new
    end
  end

  private

  def box_params
    params.require(:box).permit(:boxname, items_attributes: %i[id description avatar _destroy box_id])
  end

  def set_tenant
    ActsAsTenant.without_tenant do
      @box = Box.find(params[:id])
    end
    if current_user.guest_list.include? (@box.account.name)
      if ActsAsTenant.current_tenant != @box.account
        current_user.update!(tenant: @box.account.name)
        set_current_tenant(@box.account)
      end
    else
      redirect_to root_path, alert: 'You arent part of this account'
    end
  end

end
