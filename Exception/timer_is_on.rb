class TimerIsOn < StandardError
    def initialize(message = "You cant unplug now, the timer is on")
        super(message)
    end
end
