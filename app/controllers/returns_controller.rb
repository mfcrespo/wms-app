# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class ReturnsController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    unless @item.user.nil?
      redirect_to request.referrer, alert: "This Item hasnt been returned"
      return
    end
    current_user.items.append(@item)
    if @item.touch
      redirect_to @item.box, notice: "Enjoy the item"
    end
  end

  def destroy
    @item = current_user.items.find_by(id: params[:id])
    if @item.user.nil?
      redirect_to request.referrer, alert: "Not borrow"
      return
    end
    current_user.items.delete(@item)
    if @item.touch
      redirect_to @item.box, notice: "Thanks for return"
    end
  end
end
