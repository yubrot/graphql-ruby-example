# frozen_string_literal: true

module Gre
  module Interfaces
    module Error
      include BaseInterface

      description "Common interface for application errors."

      field :message, String,
            null: false,
            description: "Human-readable description of the error."
      field :code, Integer,
            null: false,
            description: "The HTTP status code that most closely matches the reason for the error."
    end
  end
end
