# frozen_string_literal: true

require "graphql/rake_task"

GraphQL::RakeTask.new(
  namespace: "graphql:gre",
  directory: Rails.root.join("app/graphql/gre"),
  schema_name: "Gre::Schema",
)
