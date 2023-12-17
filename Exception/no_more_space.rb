class NoMoreSpace < StandardError
    def initialize(message = "Basket is full")
      super(message)
    end
end