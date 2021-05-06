# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Users::InvitationsController < Devise::InvitationsController

  prepend_before_action :require_no_authentication, only: [] # Eliminates overall auth need
  prepend_before_action :require_same_user, only: [:edit, :update, :destroy] # Eliminates overall auth need
  before_action :require_admin_user, only: [:new]

  # POST /resource/invitation
  def create
    @user = User.find_by(email: invite_params[:email])
    # @user is an instance or nil
    if @user && @user.is_a_guest?(current_user.account.id)
      redirect_to request.referer, alert: "This user is already in your team"
      return
    end
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with_navigational(resource) { render :new }
    end
  end
  # PUT /resource/invitation
  #
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    update_name = params[:user].include? (:name)
    invitation_accepted = resource.errors.empty?
    yield resource if block_given?
    if !update_name
      user = User.find(resource.id)
      user.invitation_token = nil
      user.add_guest!(resource.account_id)
      sign_in(resource_name, resource)
      redirect_to root_path, notice: "You are now part of account of #{Account.find(resource.account_id).name}. Welcome!"
      # respond_with resource, location: after_accept_path_for(resource)
      return
    end
    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        resource.add_guest!(resource.account_id)
        sign_in(resource_name, resource)
        respond_with resource, location: after_accept_path_for(resource)
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit }
    end
  end
  
  def edit
    set_minimum_password_length
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  protected

  def invite_resource(&block)
    @user = User.find_by(email: invite_params[:email])
    # @user is an instance or nil
    if @user && @user.email != current_user.email
      # invite! instance method returns a Mail::Message instance
      @user.account_id = current_user.account.id
      @user.invite!(current_user)
      # return the user instance to match expected return type
      @user
    else
      # invite! class method returns invitable var, which is a User instance
      resource_class.invite!(invite_params, current_inviter, &block)
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private
  def update_resource_params
    params.require(:user).permit(:username, :email, :invitation_token, :password, :password_confirmation)
  end

  def require_same_user
    sign_out :user
  end

  def require_admin_user 
    redirect_to root_path, notice: "You arent Admin" unless current_user.is_admin?
  end

end