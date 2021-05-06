# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class AccountsController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @account = current_user.account
    if @account.update(account_params)
      redirect_to root_path, notice: 'Account updated succesfully'
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end

end
