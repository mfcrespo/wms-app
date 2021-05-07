# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

require 'rqrcode'

class Box < ApplicationRecord
  belongs_to :user
  belongs_to :account
  acts_as_tenant(:account)

  has_one_attached :qr_code, dependent: :destroy

  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true

  validates :boxname, presence: true, uniqueness: {scope: :account, case_sensitive: false}
  validate :select_plan?

  def select_plan?
    if self.new_record? && (user.boxes.count > 0) && (user.plan == 'free')
      errors.add(:base, "Free plan cannot have more than one box")
    elsif self.new_record? && (user.boxes.count > 4) && (user.plan == 'moderate')
      errors.add(:base, "Moderate plans cannot have more than five boxes")
    elsif self.new_record? && (user.plan == 'No plan')
      errors.add(:base, "You cannot created boxes.")
    else
      # Unlimited
    end
  end

  def add_qr_code(url)
    if !qr_code.attached?
      qrcode = RQRCode::QRCode.new(url)
      IO.binwrite("/tmp/#{id}.png", qrcode.as_png.to_s)
      qr_code.attach(io: File.open("/tmp/#{id}.png"), filename: "Box-#{id}.png")
    end
  end
  
end
