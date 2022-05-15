# Gleam on Beam: Elixir's safe escape hatch

My long time background is, which may be surprising, is PHP. When moving from PHP I have tried a bunch of technologies, which included creating mobile apps for iOS and Android.

For the mobile app I picked Dart/Flutter for the frontend - nowadays one could try [https://github.com/elixir-desktop/desktop](Elixir-Desktop), which let's you run Elixir code on iOS/Android - and for the backend I picked Phoenix. I had a great time learning both but I really missed the typing in Elixir/Phoenix while onboarding onto both.

The first iterations also had some runtime match errors sneaking into staging due to using pattern matching and not enough `with` or changesets. I simply happen to 'let it crash', unreasonably.

The Dart/Flutter experience was different. While there were bugs and not everything was perfect overall the onboarding was awesome because Flutter was mostly declarative and DOM-like and the tooling made it easy to not just use `dynamic` but almost always use explicit static typing. Why?

The IDE (vscode) showed type hints right away, without any delay (like the Elixir typing with type specs and Dialiyzer). The IDE offered up options to pick and function documentation alongside when moving through the vast amounts of Flutter build-in types/components to compose the application off.

While I did not fell for Dart, it has its culprits, I clearly missed that kind of type safety and helpfulness in Elixir/Phoenix.

## "Let it crash"

* A) Falsy assumption: Application errors happen at runtime and we just do not handle them. When taking over larger Phoenix projects I have for instance seen a lot of "(MatchError) no match of right hand side value" in Sentry.io logs.
* B) Truthy assumption: A failing process does not need to kill the system. This also allows for self healing where certain networked resources are not available briefly. On the BEAM without global state and objects we can more or less safely just crash and restart processes.

Erlang and Elixir help a lot on following happy pathes when resources an application requires are set to be available under usual circumstances. So B) is covered out of the box using Beam/OTP for the most part. However A) is not covered. A lot of runtime errors can occur that have nothing to do at all with unexpected errors.

## Types to the rescue

Here a statically and strictly typed language can help us. Erlang people know this, see <https://github.com/stars/michallepicki/lists/erlang-and-static-types>.

* Reason for tools like Dialzyer and to some degree Credo
* Reason for numerous attempts to bring typing to Erlang, the last one being `erlt` by the WhatsApp Team, released into the public about 12 month ago: <https://github.com/WhatsApp/erlt>
* Reason for numerous to bring typing to Erlang or write typed languages against the Beam VM such as: Lisp-Flavoured-Erlang, Alpaca, Hamler, Purerl, Elchemy and Gleam.

## What sets Gleam apart

1. Great care around simplicity and DX: Many of the attempts to bring typing to the Beam make it hard to pick up for developers not familiar with Lisp, Haskell or ELm. And let's be honest, compared to JavaScript these are ultra-niche. So next to immutability and strict typing developers are also forced to know these and/or understand these ultra niche technologies.
2. Targets Erlang and Javascript. If there is more financial support the main developer would like to add C/native as a target.
3. The compiler is written in Rust, while compiling the Gleam compiler takes about 30s to 1minute, compiling gleam is ultra snappy and at the same time yields compile time garantuees.
4. Interacts with Erlang/OTP or with NodeJS or Deno.

In the Gleam language development, great care is taken to not add to much to a languages strangeness-budget. Not every feature one could have is implemented because of this. The language interface or surface is being kept small for this reason. It should be easy to pick up.

With all that said, let's dive in a bit:

## Demo time

Demo in this repo <https://github.com/inoas/gleam-elixir-phoenix-liveview-counter/>.

Make sure you have got erlang, elixir gleam and rebar installed. See below for some instructions.

Run via:

```sh
bin/dev/run
```

## Play time

### How you would get started for real

A) Install ASDF <https://asdf-vm.com/guide/getting-started.html>

```sh
brew install asdf # Mac OS only, other instructions above
```

B) Install Erlang, NodeJS, Gleam, create gleam dummy app, run tests on both targets:

```sh
asdf install erlang latest
asdf install nodejs latest
asdf install gleam latest
gleam new my_app
cd my_app
gleam test --target erlang; gleam test --target javascript
```

### What we will do

Toying around together on <https://johndoneth.github.io/gleam-playground/>

Caveat: Only one module, no dependencies except gleam's included prelude and gleam_stdlib.

Going through examples found here: <https://gleam.run/book/tour/>

## Closing Words

What Gleam misses, in my book:

* The compiler, to be able to deal with broken ASTs and still offer good help thus that we can have autosuggestions/completion and better IDE tooling.
* Complete exhaustiveness checks on `case` statements

Both of these features are planned and/or already worked on. Other than that, all that is left is eco-system, libraries, more develoeprs, more users. There is already a lot of it out there, including JSON-Decoders, support for Protocol-Buffers, HTTP1/2 servers, websocket support is being worked on. See <https://github.com/gleam-lang/awesome-gleam>.

So in short, we need you, we want you :).

The Gleam community is very friendly, and not snobbish at all and welcomes developers of all trades and levels: <https://discord.gg/twY7ZhKTM3> and <https://github.com/gleam-lang/gleam/discussions> and <https://gleam.run>
