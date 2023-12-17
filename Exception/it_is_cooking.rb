class ITISCOOKING < StandardError
    def initialize(message = "The timer is on, you cant open the lid")
      super(message)
    end
end  