# A state is a container of entities
class State
  attr_accessor :entities

  def initialize
    @entities = Array.new
  end
end
