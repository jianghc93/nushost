class User < ActiveRecord::Base
  has_many :participants
  has_many :events , through: :participants
end
