class MissingIngredients < StandardError
    def initialize(message = "Ingredient does not exist in the basket")
      super(message)
    end
end 