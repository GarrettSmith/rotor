# Add the ability to add objects that supply their own key
class Hash

  # Add an object that supplies its own key from obj.key
  def <<(obj)
    if obj.respond_to? :key
      store(obj.key, obj)
    else
      raise ArgumentError, "object does not respond to key"
    end
  end

end
