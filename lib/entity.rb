# Entity represents an object within a Scene.
class Entity

  # Metaprogramming voodoo
  def metaclass
    class << self; self; end
  end

  # Create an Entity from a hash of properties.
  def initialize(hsh={})
    @properties = Array.new
    add_properties(hsh)
  end

  # Load an Entity from a YAML file.
  def self.load(file_path)
    require 'yaml'
    hsh = YAML.load_file(file_path)
    Entity.new(hsh)
  end

  # An entity is equal to another entity if the both have the same
  # property, value pairs.
  def eql?(ent)
    if ent.respond_to? :properties
      self.properties == ent.properties
    else
      false
    end
  end

  # Returns a hash of the entity's property, value pairs.
  def properties
    @properties.inject({}) do |hsh, prop|
      hsh[prop] = self.send(prop)
      hsh
    end
  end

  # Add a hash of property, value pairs.
  def add_properties(hsh)
    hsh.each do |key, val|
      add_property(key, val)
    end
  end

  # Dynamically add a property to the entity and the associated getters
  # and setters.
  def add_property(property, value=nil)
    instance_variable = to_instance_variable(property)

    # Add the property as an instance variable
    self.instance_variable_set(instance_variable, value)

    # Define methods for the property
    # Getter
    self.metaclass.send(:define_method, property.to_sym) do
      instance_variable_get(instance_variable)
    end

    # Setter
    self.metaclass.send(:define_method, "#{property}=".to_sym) do |val|
      instance_variable_set(instance_variable, val)
    end

    #Add to the list array of properties
    @properties << property.to_sym

    # Return value
    value
  end

  #Remove a property
  def remove_property(property)
    instance_variable = to_instance_variable(property)

    # get the value to return later
    value = self.send(property.to_sym)

    # remove the instance variable
    self.instance_variable_set(instance_variable, nil)

    # remove methods for the property
    # Getter
    self.metaclass.send(:remove_method, property.to_sym)

    # Setter
    self.metaclass.send(:remove_method, "#{property}=".to_sym) 

    #remove from the array of properties
    @properties.delete(property.to_sym)

    # Return value
    value
  end

  private

    # Change a string (or anything that can be coerced into a string)
    # into a symbol for the equivalent instance variable.
    def to_instance_variable(val)
      "@#{val}".to_sym
    end

end
