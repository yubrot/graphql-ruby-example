# graphql-ruby-example

This Rails 8 example project provides some snippets and suggestions to make good use of [graphql-ruby](https://graphql-ruby.org/).

- [`graphql-ruby` Error Design and Implementation (Japanese)](https://product.st.inc/entry/2024/11/22/120625)
- [Ensuring that the GraphQL schema is committed and up-to-date](./.github/workflows/ci.yml#L58)
- Rearranged directory structure under [`/app/graphql/gre/`](./app/graphql/gre/)
- Switch `ActiveRecord::Base.connected_to(role:)` by [whether the query is mutation or not](./app/controllers/graphql_controller.rb#L14)
- [ObjectTypeRestriction](./app/graphql/gre/concerns/object_type_restriction.rb): This [prevents unexpected `object` initialization](./app/graphql/gre/types/base_object.rb#L13), e.g. [User](./app/graphql/gre/types/user.rb#L8), [Activity](./app/graphql/gre/types/activity.rb#L8), ..
- [FieldError](./app/graphql/gre/field_error.rb): This simplifies resolver implementations that use unions to represent possible application errors, e.g. [RegisterUser](./app/graphql/gre/mutations/register_user.rb)
- Uniformed [Union and Interface Resolution](./app/graphql/gre/schema.rb#L19) based on ObjectTypeRestriction and FieldError
- [InlineUnionTypes](./app/graphql/gre/concerns//inline_union_types.rb) provides a way to write possible types of unions inline, e.g. [RegisterUser](./app/graphql/gre/mutations/register_user.rb)
- [`have_graphql_response` matcher](./spec/support/graphql_matchers/have_graphql_response.rb)

## Run

```sh
git clone https://github.com/yubrot/graphql-ruby-example.git
cd graphql-ruby-example
bin/setup # or bin/setup --skip-server; bin/dev
# Open http://127.0.0.1:3000/graphiql on your browser
```

## Development

```sh
# Lint
bin/rubocop -a

# Test
bin/rspec

# Update GraphQL Schema
bin/rake graphql:gre:schema:idl
```
