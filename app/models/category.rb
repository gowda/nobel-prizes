# frozen_string_literal: true

class Category < ApplicationRecord
  self.primary_key = :cid

  before_create :assign_id

  validates :name, presence: true, allow_nil: false
  validates :short, presence: true, allow_nil: false

  has_many :prizes, dependent: :destroy

  private

  def assign_id
    self.id = short.downcase
  end
end
