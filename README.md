# graphql-ruby-example

This Rails 8 example project provides several snippets and suggestions to make good use of [graphql-ruby](https://graphql-ruby.org/).

- [Ensuring that the GraphQL schema is committed and up-to-date](./.github/workflows/ci.yml#L58)
- [Rearranged directory structure under `/app/graphql`](./app/graphql)
- [Object type restriction](./app/graphql/gre/concerns/object_type_restriction.rb)
  - [Union and Interface Resolution from object type restrictions](./app/graphql/gre/schema.rb#L19)

## Try it

```sh
git clone https://github.com/yubrot/graphql-ruby-example.git
cd graphql-ruby-example
bin/setup
# Open http://127.0.0.1:3000/graphiql on your browser
```

## Development

```sh
# Lint
bin/rubocop -a

# Test
bin/rspec

# Run
bin/dev

# Update GraphQL Schema
bin/rake graphql:gre:schema:idl
```
