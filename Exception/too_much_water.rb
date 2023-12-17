class TooMuchWater < StandardError
    def initialize(message = "You added too much water")
      super(message)
    end
end