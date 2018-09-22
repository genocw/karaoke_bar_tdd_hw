require("minitest/autorun")
require("minitest/rg")
require_relative("../guest.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../k_bar.rb")

class TestGuest < MiniTest::Test

  def setup()
    @song1 = Song.new("Hey Jude", "The Beatles")

    @guest1 = Guest.new("Sally", 100, @song1)
    @guest2 = Guest.new("Billy", 15)
    # guest2 can't afford a space in the room

    @room1 = Room.new("Room1", 1)

    @bar1 = KBar.new("MmmBop", 1000, [@room1], [@song1])
  end

  def test_has_name()
    assert_equal("Sally", @guest1.name())
  end

  def test_has_wallet()
    assert_equal(100, @guest1.wallet())
  end

  def test_has_fav_song()
    assert_equal(@song1, @guest1.fav())
  end

  def test_can_afford()
    assert(@guest1.can_afford?(@room1))
  end

  def test_cant_afford()
    assert_equal(false, @guest2.can_afford?(@room1))
  end

  def test_can_buy__enough_money()
    @guest1.buy(@room1)
    assert_equal(80, @guest1.wallet)
  end

  def test_can_buy__not_enough_money()
    @guest2.buy(@room1)
    assert_equal(15, @guest2.wallet)
  end

  def test_find_fav()
    assert_equal("THEY HAVE MY SONG!", @guest1.find_fav(@bar1.songs()))
  end

end
