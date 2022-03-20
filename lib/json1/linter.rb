module Json1
  class Linter
    WHITESPACES = [
      "\u0020",
      "\u000A",
      "\u000D",
      "\u0009"
    ].freeze

    def initialize(source)
      @en = source.each_char
      @char = nil

      advance
    end

    def run
      expect_json
      true
    end

    private def expect_json
      consume_whitespace
      expect_value
      consume_whitespace
      expect_eof
    end

    private def expect_value
      case @char
      when "{"
        expect_object
      when "["
        expect_array
      when "\""
        expect_string
      when "t"
        expect_true
      when "f"
        expect_false
      when "n"
        expect_null
      else
        false
      end
    end

    private def expect_object
      raise NotImplementedError
    end

    private def expect_array
      raise NotImplementedError
    end

    private def expect_string
      raise NotImplementedError
    end

    private def expect_true
      raise NotImplementedError
    end

    private def expect_false
      raise NotImplementedError
    end

    private def expect_null
      expect("n")
      expect("u")
      expect("l")
      expect("l")
    end

    private def consume_whitespace
      while WHITESPACES.include?(@char)
        advance
      end
      true
    end

    private def expect_eof
      if !@char.nil?
        raise "expected EOF but got '%s'" % [@char]
      end
      true
    end

    private def expect(c)
      if @char != c
        raise "expected '%s' but got '%s'" % [c, @char]
      end
      advance
      true
    end

    private def advance
      @char = @en.next
    rescue StopIteration
      @char = nil
    end
  end
end
