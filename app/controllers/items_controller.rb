# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class ItemsController < ApplicationController

  def new
    box = Box.find(params[:box_id])
    @items = box.items.build
  end

  def create
    box = Box.find(params[:box_id])
    @items = box.items.build(items_params)
    if @items.save
      redirect_to box_path(box), notice: 'Added new item to box'
    else
      render :new
    end

  end

  def items_params
    params.require(:item).permit(:description, :avatar)
  end

end
