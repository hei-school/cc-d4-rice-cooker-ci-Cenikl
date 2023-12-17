class EmptyBasket < StandardError
    def initialize(message = "The basket is empty")
      super(message)
    end
end