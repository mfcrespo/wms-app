# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

class Item < ApplicationRecord
  belongs_to :box
  belongs_to :user, optional: true
  has_one_attached :avatar, dependent: :destroy

  validates :description, presence: true

  validate :file_type

  def file_type
    if !avatar.attached? || (avatar.attached? && !avatar.image?)
      !avatar.purge if avatar.persisted?
      errors.add(:avatar, 'Image valid must be a JPG or PNG file')
    end
  end

end
