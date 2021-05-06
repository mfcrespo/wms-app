# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class BoxesController < ApplicationController
  
  def index
    @boxes = Box.all
  end

  def show
  end

  def new
    @box = ActsAsTenant.current_tenant.boxes.new
  end

  def create
    @box = ActsAsTenant.current_tenant.boxes.new(box_params)
    if @box.save
      redirect_to root_path, notice: 'Box succesfully created'
    else
      render :new
    end
  end

  private

  def box_params
    params.require(:box).permit(:boxname)
  end
end
