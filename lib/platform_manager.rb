require 'facter'

# A manager to retrieve information about the current platform.
class PlatformManager

  # Loads all the facts and adds each as a method to PlatformManager.
  Facter.loadfacts
  Facter.collection.list.each do |fact|
    define_method(fact) do
      Facter.send fact
    end
  end

end
