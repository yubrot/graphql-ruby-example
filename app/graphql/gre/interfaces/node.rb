# frozen_string_literal: true

module Gre
  module Interfaces
    module Node
      include BaseInterface

      field :id, ID, null: false

      def id = context.schema.id_from_object(object, self.class, context)
    end
  end
end
