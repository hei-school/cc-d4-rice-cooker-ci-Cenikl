class NoMoreRice < StandardError
    def initialize(message = "Not enough rice in the storage")
      super(message)
    end
end