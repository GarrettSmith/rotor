# A manager provide a global service to the framework.
class Manager

  #Return the symbol of this object's class
  def key
    self.class.name.to_sym
  end
end
