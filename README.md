#Installation

- create a `secrets.yml` file. use `rake secret` to generate keys
```
secret_key_base:
 
test:
  secret_key_base:
 
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

set up your `.env` file with the following keys

- `DB_NAME`
- `TEST_DB_NAME`
- `DB_USER`
- `DB_PASS`
