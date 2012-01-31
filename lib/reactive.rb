require 'metaid'

# An immutable reactive value
# TODO cache the value so it does not need to be recalculated unless 
# there is a change in variables
class Reactive
  def initialize(&blk)
    @value = blk
    wrap_methods
  end

  private
    def value
      @value.call
    end

    def wrap_methods
      value.public_methods(false).each do |meth|
        meta_def meth do |*args|
          value.send meth, *args
        end
      end
    end
end
