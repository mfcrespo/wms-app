# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class CustomDeviseMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def invitation_instructions(record, token, opts={})
    opts[:subject] = "You have been invited to join"
    @token = token
    devise_mail(record, record.invitation_instructions || :invitation_instructions, opts)
  end
end