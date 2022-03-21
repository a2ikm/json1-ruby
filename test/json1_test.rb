# frozen_string_literal: true

require "test_helper"

class Json1Test < Test::Unit::TestCase
  test ".parse" do
    assert_equal("source", Json1.parse("source"))
  end

  test ".lint" do
    assert_equal(true, Json1.lint("null"))

    assert_raise(RuntimeError) { Json1.lint("") }
  end
end
