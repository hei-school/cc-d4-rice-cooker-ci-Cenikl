class TooMuchWater < StandardError
    def initialize(message = "You added to water")
      super(message)
    end
end