module Json1
  class Token
    TYPES = [
      :eof,
      :null,
      :true,
      :false,
      :string,
      :lsqbracket,
      :rsqbracket
    ].freeze

    attr_reader :type, :literal

    def initialize(type, literal)
      raise "unknown token type: #{type.inspect}" unless TYPES.include?(type)

      @type = type
      @literal = literal

      freeze
    end
  end
end
