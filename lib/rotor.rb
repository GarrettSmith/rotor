##
# A Contaienr has a collection of elements that can be read, added to, 
# removed from, updated and removed.
class Container
  ## 
  # All the elements within the Container.
  attr_reader :elements

  ##
  # Adds an element to the Container.
  #
  # Elements must ::respond_to? :key if @elements is a Hash.
  def <<(obj)
    if @elements.respond_to? :<<
      @elements << obj
    elsif @element.respond_to?(:store) && obj.respond_to?(:key)
      @elements[obj.key] = obj
    else
        raise NoMethodError, "#{@elements.class} does not respond to << or store."
    end
  end

  ##
  # Removes an element from this Container.
  #
  # If @elements is a Hash removes all elements with the key from this
  # Container.
  def delete(obj)
    @elements.delete obj
  end

  ##
  # Destroys all elements in the Container.
  def destroy
    @elements.each { |e| e.destroy }
  end

  ##
  # Updates all elements in the Container
  def update(time)
    @elements.each { |e| e.update(time) }
  end
end

