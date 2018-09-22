class Guest

  attr_reader :name, :fav
  attr_accessor :wallet

  def initialize(name, wallet, fav_song=nil)
    @name = name
    @wallet = wallet.to_f
    @fav = fav_song
  end

  def can_afford?(thing)
    @wallet >= thing.price
  end

  def buy(thing)
    if can_afford?(thing)
      @wallet -= thing.price
    end
  end

  def find_fav(playlist)
    for song in playlist
      if song == @fav
        return "THEY HAVE MY SONG!"
      end
    end
  end

end
