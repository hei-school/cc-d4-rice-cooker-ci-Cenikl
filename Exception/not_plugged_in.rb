class NotPluggedInError < StandardError
    def initialize(message = "Rice cooker is not plugged in")
      super(message)
    end
end