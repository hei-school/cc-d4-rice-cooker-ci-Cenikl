class TooMuchRice < StandardError
    def initialize(message = "You added too much rice")
      super(message)
    end
end