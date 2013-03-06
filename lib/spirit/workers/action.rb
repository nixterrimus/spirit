module Worker
  class ActionWorker
    include SuckerPunch::Worker

    def perform(action)
      action.apply
    end
  end
end
