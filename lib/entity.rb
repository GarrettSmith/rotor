##
# Entity represents an object within a State.
class Entity

  @@number = 0

  attr_reader :name, :number

  def initialize(name)
    @name = name
    @number = @@number
    @@number += 1
  end

end
