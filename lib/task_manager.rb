# Handles a pool of actors to execute tasks.
class TaskManager
  require "rubinius/actor"

  Ready = Struct.new(:this)
  Work = Struct.new(:msg)

  def initialize
    @supervisor = Actor.spawn do
      supervisor = Actor.current
      work_loop = Proc.new do
        loop do
          work = Actor.receive
          #puts("Processing: #{work.msg}")
          supervisor << Ready[Actor.current]
        end
      end

      Actor.trap_exit = true
      ready_workers = []
      Worker_cores.times do |x|
        # Create workers
        ready_workers << Actor.spawn_link(&work_loop)
      end
      loop do
        Actor.receive do |f|
          f.when(Ready) do |who|
            # SNIP
          end
          f.when(Work) do |work|
            ready_workers.pop << work
          end
          f.when(Actor::DeadActorError) do |exit|
            print "Actor exited with message: #{exit.reason}\n"
            ready_workers << Actor.spawn_link(&work_loop)
          end
          end
      end
    end
  end

end
