class NoMoreWater < StandardError
    def initialize(message = "Not enough water in the storage")
      super(message)
    end
end