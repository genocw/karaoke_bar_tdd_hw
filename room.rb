class Room

  attr_reader :name
  attr_accessor :occupants, :spaces_left, :price, :current_song, :played_songs

  def initialize(name, spaces_left=10)
    @name = name
    @price = 20
    @occupants = []
    @spaces_left = spaces_left
    @current_song = []
    @played_songs = []
  end

end
