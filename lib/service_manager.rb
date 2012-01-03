# Provides an interface for systems to provide services to one another 
# and have access to a subset of properties.
module ServiceManager

  def self.register(service_name, &block)
    self.module_eval do |*args|
      block.call(args)
    end
  end

  def self.unregister(service_name)
    remove_method service_name.to_sym
  end

end
