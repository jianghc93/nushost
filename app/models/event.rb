class Event < ActiveRecord::Base
  has_many :participants, dependent: :destroy
  has_many :users , through: :participants

  validates :summary, :length => {:maximum => 50}

  def self.search(search)
    if search.to_i != 0
      where("id = ?", search)
    else
      #probably should use a gem which uses full-text search
      where('title LIKE ? OR summary LIKE ? OR description LIKE ? OR venue LIKE ? OR host LIKE ?',
            search,
            search,
            search,
            search,
            search)
    end
  end

end
