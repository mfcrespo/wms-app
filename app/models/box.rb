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

  def add_qr_code(url)
    if !qr_code.attached?
      qrcode = RQRCode::QRCode.new(url)
      IO.binwrite("/tmp/#{id}.png", qrcode.as_png.to_s)
      qr_code.attach(io: File.open("/tmp/#{id}.png"), filename: "Box-#{id}.png")
    end
  end
  
end
