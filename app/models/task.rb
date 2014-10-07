class Task < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 3, maximum: 254 }
  validates :location, length: { maximum: 254 }
end
