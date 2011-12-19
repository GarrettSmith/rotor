# Handles a pool of actors to execute tasks.
class TaskManager
  require "actor"
  require "facter"

  Ready = Struct.new(:this)
  Work = Struct.new(:msg)

  Cores = Facter.sp_number_processors
  Worker_cores = (Cores - 1) > 0 ? (Cores - 1) : 1

  def 

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

  10.times do |idx|
    @supervisor << Work[idx]
  end
  sleep 1
end
