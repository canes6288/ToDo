class Task < ActiveRecord::Base
  # These lines validate title to have to exist and have a length of 3 - 254 characters
  validates :title, presence: true, length: { minimum: 3, maximum: 254 }
  # These lines validate location to have a max length of 254 characters
  validates :location, length: { maximum: 254 }
  # These lines validate priority to be between 1-3 as integers
  validates :priority, inclusion: 0..3
end
