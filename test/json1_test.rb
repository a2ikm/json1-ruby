# frozen_string_literal: true

require "test_helper"

class Json1Test < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Json1.const_defined?(:VERSION)
    end
  end

  test "something useful" do
    assert_equal("expected", "actual")
  end
end
