require 'gosu'
require 'texplay'
require_relative '../map'
require_relative 'test_city_factory'

# A simple way to output the various maps
# the reason for this file is to be able to view the maps during the
# development of the map generator
class CityMapOutput < Gosu::Window
  def initialize
    city_factory = TestCityFactory.new
    @x, @y = city_factory.width, city_factory.height

    super @x * 10, @y * 10, false

    @city = city_factory.build
    self.caption = @city.name
  end

  def update
  end

  def draw
    @city.tiles.each do |tile|
      color = pick_tile_color(tile)

      draw_quad(
          tile.x * 10, tile.y * 10, color,
          tile.x * 10 + 10, tile.y * 10, color,
          tile.x * 10, tile.y * 10 + 10, color,
          tile.x * 10 + 10, tile.y * 10 + 10, color,
          0)
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  private

  def pick_tile_color(tile)
    if tile.type == :open
      color = Gosu::Color.new(0xff005082)
    elsif tile.type == :entrance
      color = Gosu::Color.new(0xff0d6a05)
    elsif tile.type == :wall
      color = Gosu::Color.new(0xff555555)
    elsif tile.type == :door
      color = Gosu::Color.new(0xffffb55b)
    end
    color
  end
end

window = CityMapOutput.new
window.show
