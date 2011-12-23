##
# Inherit from Rotor to create your own game.
class Rotor
  attr_reader :scenes, :managers

  def initialize
    @scenes = Array.new
    @managers = Array.new
  end

end
