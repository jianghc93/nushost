class Event < ActiveRecord::Base
  validates :summary, :length => {:maximum => 30}
end
