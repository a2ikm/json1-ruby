# frozen_string_literal: true

require_relative "json1/version"
require_relative "json1/parser"

module Json1
  class Error < StandardError; end

  def self.parse(source)
    Parser.new(source).run
  end
end
