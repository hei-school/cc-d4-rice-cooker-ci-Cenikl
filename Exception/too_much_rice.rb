class TooMuchRice < StandardError
    def initialize(message = "You added to much rice")
      super(message)
    end
end