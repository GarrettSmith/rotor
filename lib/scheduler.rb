# Scheduler is responsible for issuing all system's tasks via the
# TaskManager.
class Scheduler
  attr_reader :start_time

  def initialize
    @start_time = Time.now
  end
end
