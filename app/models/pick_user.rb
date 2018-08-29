class PickUser < ApplicationRecord
  belongs_to :pick
  belongs_to :user
end
