---
theme: unicorn
---
# Gleam on Beam: Elixir's safe escape hatch

Briefly about me:

- Full Stack Dev.
- Long time background is PHP <mdi-emoticon-neutral /> & CakePHP <mdi-emoticon />.
- Contributor to Gleam's stdlib: <https://github.com/gleam-lang/stdlib/> <mdi-emoticon-excited />.
- When moving from PHP, I have tried a bunch of technologies, which included picking Phoenix and Flutter for creating mobile apps for iOS/Android.

---

## Story/1

### Picking new technologies

- For the mobile app I picked Dart/Flutter as the frontend technology.
  - Nowadays one could try <https://github.com/elixir-desktop/desktop> (Elixir-Desktop), which let's you run Elixir code on iOS/Android as well as Mac, Linux and Windows.
- For the backend I picked Elixir/Phoenix.
- I had a great time learning both but I really missed the typing in Elixir/Phoenix while onboarding onto both.

---

## Story/2

### First experiences

- The first iterations of the backend/API (Phoenix) some runtime match errors sneaking into staging.
- Errors were due to using pattern matching and not enough `with` or change sets for validation.
- I simply happen to *"let it crash"* - unreasonably though.

---

## Story/3

### Dart/Flutter

- The Dart/Flutter experience was different.
- Bugs existed as well but the overall the onboarding was awesome
- Reasons:
  - Flutter was mostly declarative and DOM-like
  - Flutter/Dart tooling made it rewarding to not just use `dynamic` but almost always use explicit static typing. Why?

---

## Story/4

### DX benefits of static typing

- The IDE (vscode) showed type hints right away
- Without any delay (like the Elixir typing with type specs and Dialiyzer)
- The IDE offered up options to pick and function documentation alongside when moving through the vast amounts of Flutter build-in types/components to compose the application off.

<mdi-arrow-right-thick /> Dart has its culprits but I clearly missed that kind of type safety and DX in Elixir/Phoenix.

---

## Story/5

### "Let it crash!"

1. `Bad crashes`: Application errors happen at runtime and we just do not handle them. When taking over larger Phoenix projects I have for instance seen a lot of `(MatchError) no match of right hand side value` in Sentry.io logs.
2. `Good crashes`: A failing process does not need to kill the system. This also allows for self healing where certain networked resources are not available briefly. On the BEAM without global state and objects we can more or less safely just crash and restart processes.

Obviously crashes are never good ;-)

---

## Story/6

### "Lessons learned!"

Erlang and Elixir help a lot on following happy paths:

- When resources an application requires are set to be available under usual circumstances, it runs
- When such resources are temporarily unavailable, some processes crash and restart

<mdi-arrow-right-thick /> The `good crashes` are handled by well written Beam/OTP apps.

What about the `bad crashes`?

- A lot of runtime errors can occur that have nothing to do at all with unexpected errors.
- Change sets or other forms of input validation help.
- Type specs, and schemata such as Json-Schema, XML-Schema/XSD, GraphQL help.
- Unit tests help.

<mdi-arrow-right-thick /> Static typing can help to avoid many of these bad crashes

---

## Story/7

### Types to the rescue

- Erlang community has tried to fix this within and outside of Erlang, see <https://github.com/stars/michallepicki/lists/erlang-and-static-types>.
- Reason for tools like Dialzyer and to some degree Credo.
- Reason for numerous attempts to bring typing to Erlang, the last one being `erlt` by the WhatsApp Team, released into the public about 12 month ago: <https://github.com/WhatsApp/erlt>.
- Reason for numerous to bring typing to Erlang or write typed languages against the Beam VM such as: Lisp-Flavoured-Erlang, Alpaca, Hamler, Purerl, Elchemy and Gleam.

---

## Gleam/1

### What Gleam avoids

1. Great care around simplicity and DX
   - Many of the attempts to bring typing to the Beam make it hard to pick up for developers not familiar with Lisp, Haskell or Elm.
   - And let's be honest, compared to JavaScript these are ultra-niche.
   - So next to immutability and strict typing developers are also forced to know these and/or understand these ultra niche technologies.

---

## Gleam/2

### What sets Gleam apart

1. Average developer happiness matters:
   - Gleam language development: Great care to not add to much to a languages' strangeness-budget.
   - Not every feature one could think of or desire is implemented.
   - The language interface or surface is being kept small for this reason.
   - It should be easy to pick up.
2. Targets Erlang and Javascript. If there is more financial support the main developer would like to add C/native as a target.
3. The compiler is written in Rust, while compiling the Gleam compiler takes about 30s to 1minute, compiling gleam is ultra snappy and at the same time yields compile time garantuees.
4. Interacts with Erlang/OTP or with NodeJS or Deno.

---

## Gleam/3

**With all that being said, let's dive in a bit!**

---

## Gleam/4

### Demo time

Demo and this talk in available here: <https://github.com/inoas/gleam-elixir-phoenix-liveview-counter/>.

Run at home? Make you have got Erlang, Elixir, Gleam and Rebar installed. See below for some instructions.

Run via:

```sh
bin/dev/run && open http://localhost:4000/
```

Run the slides via:

```sh
bin/dev/slides && open http://localhost:3030
```

&nbsp;
### Demo link

<mdi-arrow-right-thick /> <http://localhost:4000/>

---

## Gleam/5

### How to install gleam

1. Install ASDF <https://asdf-vm.com/guide/getting-started.html>
   ```sh
   brew install asdf # Mac OS only, other instructions above
   ```
2. Install Erlang, NodeJS, Gleam, create gleam dummy app, run tests on both targets:
   ```sh
   asdf install erlang latest
   asdf install nodejs latest
   asdf install gleam latest
   ```
3. Create a Gleam dummy app, run tests on both targets:
   ```sh
   gleam new my_app
   cd my_app
   gleam test --target erlang; gleam test --target javascript
   ```

---

## Gleam/6

### Playtime

- Toying around together on <https://johndoneth.github.io/gleam-playground/>.
- Caveat: Only one module, no dependencies except gleam's included prelude and `gleam_stdlib`.
- Going through some examples found here: <https://gleam.run/book/tour/>.

---

## Closing Words/1

### Is Gleam production ready?

To my knowledge the main author certainly thinks so. People are using it in production. In the end Gleam generated rather readable Erlang (or JavaScript).

### Anything bad?

- Complete exhaustiveness checks on `case` statements
- The compiler, to be able to deal with broken/partial ASTs and still offer good help
  - Thus that we can have autosuggestions/completion and better IDE tooling.
- To my knowledge, these features are on the core developer's lists

---

## Closing Words/2

### The state of matter

- The language is pretty stable.
- The main author has stated that they intent to not break any language syntax or core language interfaces
- The eco-system needs help, libraries, more developers and more users
- There is already a lot of it out there, including:
  - including JSON-Decoders, support for Protocol-Buffers, HTTP1/2 servers
- websocket support is being worked on
- For more See <https://github.com/gleam-lang/awesome-gleam>.

---

## Closing Words/3

### Thanks and shout-outs

- Joe & Team for creating Erlang
- José & Chris for creating Elixir, Phoenix & LiveView
- Louis for creating Gleam
- The Gleam community and especially *michallepicki*, *rattard* and *HarryET* for helping out.

---

## Closing Words/4

### Become shiny

The Gleam community is very friendly, not snobbish at all, and welcomes developers of all trades and levels!

**<mdi-emoticon-excited /> Gleam needs you - Gleam wants you! You want Gleam - you need Gleam! <mdi-emoticon-excited />**

... and no, it is not going to replace Elixir anytime soon!

- Discord: <https://discord.gg/twY7ZhKTM3>
- GitHub Discussions: <https://github.com/gleam-lang/gleam/discussions>
- Gleam on the web: <https://gleam.run>
