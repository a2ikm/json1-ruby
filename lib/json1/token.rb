module Json1
  class Token
    attr_reader :type, :literal

    def initialize(type, literal)
      @type = type
      @literal = literal

      freeze
    end
  end
end
