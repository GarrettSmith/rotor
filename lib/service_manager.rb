require 'metaid'

# Provides an interface for systems to provide services to one another 
# and have access to a subset of properties.
class ServiceManager
  alias register meta_def
  alias unregister meta_remove

end
