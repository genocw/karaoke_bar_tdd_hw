require("minitest/autorun")
require("minitest/rg")
require_relative("../k_bar.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require("pry")

class TestKBar < MiniTest::Test

  def setup()
    @guest1 = Guest.new("Sally", 100)
    @guest2 = Guest.new("Billy", 15)
    # guest2 can't afford a space in the room

    @song1 = Song.new("Hey Jude", "The Beatles")
    @song2 = Song.new("Nothing Else Matters", "Metallica")
    @song3 = Song.new("Fitzcaraldo", "The Frames")
    # song3 not added to bar's list of songs

    @room1 = Room.new("Room1", 1)
    # room1 has 1 space left
    @room2 = Room.new("Room2", 0)
    # room2 has no spaces left

    @bar1 = KBar.new("MmmBop", 1000, [@room1, @room2], [@song1, @song2])
    # bar1 has 1 room and 2 song
  end

  def test_has_name()
    assert_equal("MmmBop", @bar1.name())
  end

  def test_has_till()
    assert_equal(1000, @bar1.till)
  end

  def test_has_rooms()
    assert_equal([@room1, @room2], @bar1.rooms())
  end

  def test_has_songs()
    assert_equal([@song1, @song2], @bar1.songs())
  end

  def test_can_check_in()
    @bar1.check_in(@guest1, @room1)
    assert_equal(80, @guest1.wallet())
    # check guest wallet decreases
    assert_equal(1020, @bar1.till())
    # check till gets money
    assert_equal([@guest1], @room1.occupants())
    # check guest added to occupants array
    assert_equal(0, @room1.spaces_left())
    # check spaces_left decreases
  end

  def test_check_in__not_enough_money()
    @bar1.check_in(@guest2, @room1)
    assert_equal(15, @guest2.wallet())
    assert_equal(1000, @bar1.till())
    assert_equal([], @room1.occupants())
    assert_equal(1, @room1.spaces_left())
  end

  def test_check_in__room_full()
    @bar1.check_in(@guest1, @room2)
    assert_equal(15, @guest2.wallet())
    assert_equal(1000, @bar1.till())
    assert_equal([], @room2.occupants())
    assert_equal(0, @room2.spaces_left())
  end

  def test_chec_in__fav_song()
    @guest3 = Guest.new("Trish", 100, @song2)
    expected = "THEY HAVE MY SONG!"
    actual = @bar1.check_in(@guest3, @room1)
    assert_equal(expected, actual)
  end

  def test_can_check_out()
    @room1.occupants.push(@guest1, @guest2)
    # room1 should now have 2 occupants and 1 space left
    assert_equal([@guest1, @guest2], @room1.occupants())
    assert_equal(1, @room1.spaces_left())

    @bar1.check_out(@guest1, @room1)
    # room1 should now have 1 occupant and 2 spaces left
    assert_equal([@guest2], @room1.occupants())
    assert_equal(2, @room1.spaces_left())
    # guest removed from occupants array
    # room's spaces_left increases by 1
  end

  def test_can_add_song()
    @room1.current_song.push(@song1)
    @bar1.add_song(@song2, @room1)
    # test current_song now song2
    assert_equal([@song2], @room1.current_song())
    # test song1 now in played_songs
    assert_equal([@song1], @room1.played_songs())
  end

  def test_add_song__song_not_in_list()
    expected = "Song not found"
    actual = @bar1.add_song(@song3, @room1)
    assert_equal(expected, actual)
  end

end
