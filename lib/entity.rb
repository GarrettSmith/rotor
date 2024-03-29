require 'metaid'

# Entity represents an object within a Scene.
#
# Standard Properties
# - name - The unique name of the entity.
# - children - An array of children entities.
class Entity

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

    # Add the property to the entity
    meta_eval { attr_accessor property }

    # Set the value of the property
    instance_variable = to_instance_variable(property)
    self.instance_variable_set(instance_variable, value) if value

    #Add to the array of properties
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
    meta_remove(property.to_sym)

    # Setter
    meta_remove("#{property}=".to_sym) 

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
