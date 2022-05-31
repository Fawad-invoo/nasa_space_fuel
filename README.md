# NasaSpace

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

- Fuel calculation endpoint http://localhost:4000/fuel_calculate

- `curl --location --request GET 'http://localhost:4000/fuel_calculate' \
--header 'Content-Type: application/json' \
--data-raw '{
    "mass": 28801,
    "flight_path": [
        {
            "launch": 9.807
        },
        {
            "land": 1.62
        },
        {
            "launch": 1.62
        },
        {
            "land": 9.807
        }
    ]
}'`
# Tests

- Run mix test to validate all test cases

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
