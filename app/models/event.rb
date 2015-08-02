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

  def size
    self.users.size
  end

  def isHost? user
    host = self.participants.select { |p| p.role == "host" }
    if user.is_a? User
      host.first.user_id == user.id
    else
      host.first.user_id == user
    end
  end

  def isParticipant? user
    if user.is_a? User
      self.users.include?(user)
    else
      !self.users.select { |u| u.id == user }.empty?
    end
  end

end
