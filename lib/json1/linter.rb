module Json1
  class Linter
    def initialize(source)
      @lexer = Lexer.new(source)
      @current = @lexer.emit # never to be nil
    end

    def run
      expect_json
    end

    private def expect_json
      expect_value
      expect_eof
    end

    private def expect_value
      case @current.type
      when :eof
        unexpected_eof
      when :null, :true, :false, :string
        advance
        true
      else
        false
      end
    end

    private def expect_eof
      unless eof?
        raise "expected EOF but got '%s'" % [@char]
      end
      true
    end

    private def unexpected_eof
      raise "unexpected EOF"
    end

    private def eof?
      @current.type == :eof
    end

    private def advance
      if @current.type != :eof
        @current = @lexer.emit
      end
    end
  end
end
