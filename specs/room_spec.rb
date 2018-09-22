require("minitest/autorun")
require("minitest/rg")
require_relative("../room.rb")

class TestRoom < MiniTest::Test

  def setup()
    @room1 = Room.new("Room1")
  end

  def test_has_name()
    assert_equal("Room1", @room1.name())
  end

  def test_starts_with_no_occupants()
    assert_equal(0, @room1.occupants.length())
  end

  def test_starts_with_10_spaces_left()
    assert_equal(10, @room1.spaces_left())
  end

  def test_has_price()
    assert_equal(20, @room1.price)
  end

  def test_has_current_song_array()
    assert_equal([], @room1.current_song())
  end

  def test_has_played_songs_array()
    assert_equal([], @room1.played_songs())
  end

end
