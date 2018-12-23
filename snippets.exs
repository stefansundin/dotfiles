iex -S mix
mix deps.get
mix format --check-formatted
MIX_ENV=prod mix compile

require IEx; IEx.pry
binding
runtime_info
:observer.start()
:debugger.start()

# inspect stuff
i(String)
# print objects
IO.puts "pid: #{inspect self()}"

[1, 2, 3] |>
  IO.inspect(label: "before") |>
  Enum.map(&(&1 * 2)) |>
  IO.inspect(label: "after") |>
  Enum.sum


http://erlang.org/doc/index.html
http://erlang.org/doc/apps/stdlib/introduction.html
http://erlang.org/doc/man/SSH_app.html
http://erlang.org/doc/apps/mnesia/Mnesia_overview.html


http://erlang.org/doc/apps/crypto/crypto.pdf
http://erlang.org/doc/apps/ssh/ssh.pdf
http://erlang.org/doc/apps/asn1/asn1.pdf
http://erlang.org/doc/apps/mnesia/mnesia.pdf
