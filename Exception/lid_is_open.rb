class LidIsOpen < StandardError
    def initialize(message = "The lid is still open")
      super(message)
    end
end