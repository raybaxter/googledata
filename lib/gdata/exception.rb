module GData
  
  class Exception < StandardError

    def initialize(string)
      @string = string
    end

    def message
      @string
    end

  end
  
end