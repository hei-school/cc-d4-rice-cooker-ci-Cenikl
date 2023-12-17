class LidIsClosed < StandardError
    def initialize(message = "The lid is still closed")
        super(message)
    end
end
