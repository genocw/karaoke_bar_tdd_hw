class KBar

  attr_reader :name
  attr_accessor :rooms, :songs, :till

  def initialize(name, till, rooms=[], songs=[])
    @name = name
    @till = till.to_f
    @rooms = rooms
    @songs = songs
  end

  def check_in(guest, room)
    # check if space left in room
    a = room.spaces_left >= 1
    # get guest to check they can afford
    b = guest.can_afford?(room)

      if a && b
        # get guest to pay
        c = guest.buy(room)
        # inc till
        @till += room.price()
        # add guest to room occupants array
        room.occupants.push(guest)
        # reduce room's spaces_left by 1
        room.spaces_left -= 1
        # check for fav song
        guest.find_fav(@songs)
      end
  end

  def check_out(guest, room)
    # remove guest from room's occupants array
    room.occupants.delete(guest)
    # inc spaces_left by 1
    room.spaces_left += 1
  end

  def add_song(song, room)
    # check if song exists?
    if @songs.include?(song)
      # copy current song to played_songs array
      room.played_songs.push(room.current_song[0])
      # replace current_song with [song]
      room.current_song.replace([song])
    else
      return "Song not found"
    end
  end

end
