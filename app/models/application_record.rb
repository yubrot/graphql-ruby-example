# frozen_string_literal: true

# Base ActiveRecord class for the application
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  connects_to database: { writing: :primary, reading: :secondary }
end
