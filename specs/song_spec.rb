require("minitest/autorun")
require("minitest/rg")
require_relative("../song.rb")

class TestSong < MiniTest::Test

  def setup()
    @song1 = Song.new("Hey Jude", "The Beatles")
  end

  def test_has_title()
    assert_equal("Hey Jude", @song1.title())
  end

  def test_has_artist()
    assert_equal("The Beatles", @song1.artist())
  end

end
