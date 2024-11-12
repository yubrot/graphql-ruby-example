# frozen_string_literal: true

module Gre
  module Enums
    # Since graphql-ruby removes `Type` suffix from schema elements,
    # we need to add it back to the class name.
    class ActivityTypeType < BaseEnum
      value "WAKEUP", value: "wakeup"
      value "BREAKFAST", value: "breakfast"
      value "LUNCH", value: "lunch"
      value "DINNER", value: "dinner"
      value "SLEEP", value: "sleep"
    end
  end
end
