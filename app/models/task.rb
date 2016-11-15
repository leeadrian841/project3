class Task < ApplicationRecord
  resourcify
  validates :name, presence: true
  validates :duration, presence: true
  validates :info, presence: true
  validates :category, presence: true
  validates :location, presence: true
  validates :price, presence: true
end
