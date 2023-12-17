class NoMoreSpace < StandardError
    def initialize(message = "Basket if full")
      super(message)
    end
end