##
# Entity represents an object within a game State.
#
# An entity should contain entities, components, or both as elements.
class Entity
  attr_accessor :name
  def initialize(name, cs*)
    @name = name
    @elements = Hash.new
    cs.each { |c| self << c }
  end

  ##
  # An entity's unique key is its name.
  def key 
    @name
  end

  ##
  # Returns all the child entities of the entity.
  def children
    @elements.select { |e| e.kind_of? Entity }
  end

  ##
  # Returns all the Component objects of this entity.
  def components
    @elements.select { |e| e.kind_of? Component }
  end
end
