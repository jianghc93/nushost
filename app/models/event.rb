class Event < ActiveRecord::Base
  validates :summary, :length => {:maximum => 50}
end
