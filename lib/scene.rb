
# A scene is a container of entities
class Scene
  attr_accessor :name
  attr_reader :entities

  def initialize(options={})
    @entities = Array.new
    @name = options[:name] 
  end

end
