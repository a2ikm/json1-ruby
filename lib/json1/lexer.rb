module Json1
  class Lexer
    WHITESPACES = [
      "\u0020",
      "\u000A",
      "\u000D",
      "\u0009"
    ].freeze

    WORDBREAKINGS = [
      "{", "}",
      "[", "]",
      "\"",
      ","
    ].freeze

    def initialize(source)
      @en = source.each_char
      @prev_char = nil
      @char = nil

      advance
    end

    def emit
      skip_whitespace

      token =
        case @char
        when nil
          read_eof
        when "\""
          read_string
        else
          read_keyword
        end

      advance
      token
    end

    private def read_eof
      Token.new(:eof, nil)
    end

    private def read_string
      literal = ""

      literal << @char
      advance

      loop do
        if eof?
          unexpected_eof
        end
        if @char == "\"" && @prev_char != "\\"
          literal << @char
          advance
          break
        end
        literal << @char
        advance
      end

      Token.new(:string, literal)
    end

    private def read_keyword
      literal = ""

      literal << @char
      advance

      loop do
        if eof? || WHITESPACES.include?(@char) || WORDBREAKINGS.include?(@char)
          break
        end
        literal << @char
        advance
      end

      case literal
      when "true"
        Token.new(:true, literal)
      when "false"
        Token.new(:false, literal)
      when "null"
        Token.new(:null, literal)
      else
        raise "unknown token: #{literal.inspect}"
      end
    end

    private def skip_whitespace
      while WHITESPACES.include?(@char)
        advance
      end
      true
    end

    private def unexpected_eof
      raise "unexpected EOF"
    end

    private def eof?
      @char.nil?
    end

    private def advance
      char = @en.next
      @prev_char = @char
      @char = char
    rescue StopIteration
      @prev_char = @char
      @char = nil
    end
  end
end
