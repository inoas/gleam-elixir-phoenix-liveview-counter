---
theme: unicorn
---
# Gleam on Beam: Elixir's safe escape hatch

Briefly about me:

- Diploma degree in Sociology, Economics & Psychology.
- Full Stack Dev since 1997/2001.
- Contributor to Gleam's stdlib: <https://github.com/gleam-lang/stdlib> <mdi-emoticon-excited /> and a bit to Gleam Playground.
- When looking for new tech, I have tried a bunch of technologies, which included picking Phoenix and Flutter for creating mobile apps for iOS/Android.

---

## Story/1

### Picking new technologies

- For the mobile app I picked Dart/Flutter as the frontend technology.
  - Nowadays one could try <https://github.com/elixir-desktop/desktop> (Elixir-Desktop), which lets you run Elixir code on iOS/Android as well as Mac, Linux and Windows.
- For the backend I picked Elixir/Phoenix.
- I had a great time learning both, but I really missed the typing in Elixir/Phoenix while onboarding.

---

## Story/2

### First experiences

- The first iterations of the backend/API (Phoenix) some runtime match errors sneaking into staging.
- Errors were due to using pattern matching and not enough `with` or change-sets for validation.
- I simply happen to *"let it crash"* - unreasonably though.


---

## Story/3

### Dart/Flutter

- The Dart/Flutter experience was different.
- Bugs existed as well, but the overall onboarding was awesome.
- Reasons:
  - Flutter was mostly declarative and DOM-like.
  - Flutter/Dart tooling made it rewarding to ***not*** use `dynamic`, but almost always use static typing.
  - Why? <mdi-arrow-right />

---

## Story/4

### DX benefits of static typing

- The IDE (vscode) showed type hints right away.
- Without any delay (like in Elixir with ElixirLS, type specs and Dialiyzer).
- The IDE offered options to pick and function documentation alongside when moving through the vast amounts of Flutter build-in types/components to compose the application of.

<mdi-arrow-right-thick /> Dart has its culprits but I clearly missed that kind of type safety and DX in Elixir/Phoenix.

---

## Story/5

### "Let it crash!"

1. `Bad crashes`: Application errors happen at runtime and we just do not handle them.
   - When taking over larger Phoenix projects I have for instance seen a lot of `(MatchError) no match of right hand side value` in Sentry.io logs.
2. `Good crashes`: A failing process does not need to kill the system. This also allows for self healing where certain networked resources are not available briefly.
   - On the BEAM without global state and objects we can more or less safely just crash and restart processes.

&nbsp;

<sub>Disclaimer: Obviously crashes are *NEVER* good! <mdi-emoticon-poop /></sub>

---

## Story/6

### "Lessons learned!"

Erlang and Elixir help a lot on following happy paths:

- When resources, an application requires, are set to be available under usual circumstances, it runs.
- When such resources are temporarily unavailable, some processes crash and restart.

<mdi-arrow-right-thick /> The `good crashes` are handled by well written Beam/OTP apps.

What about the `bad crashes`?

- A lot of runtime errors can occur that have nothing to do at all with unexpected errors.
- Change-sets or other forms of input validation help.
- Type specs, and schemata such as Json-Schema, XML-Schema/XSD, GraphQL help.
- Unit tests help.

<mdi-arrow-right-thick /> Static typing can help to avoid many of these bad crashes

---

## Story/7

### Types to the rescue

- Erlang community has tried to fix this within and outside of Erlang, see <https://github.com/stars/michallepicki/lists/erlang-and-static-types>.
- Reason for tools like Dialzyer and to some degree Credo.
- Reason for numerous attempts to bring typing to Erlang, the last one being `erlt` by the WhatsApp-team, released into the public in spring 2021: <https://github.com/WhatsApp/erlt>.
- Reason for numerous to bring typing to Erlang or write typed languages against the Beam VM such as: Lisp-Flavoured-Erlang, Alpaca, Purerl, Elchemy, Hamler, Caramel and Gleam.

---

## Gleam/1

### What Gleam avoids

1. Great care around simplicity and DX
   - Many of the attempts to bring typing to the Beam make it hard to pick up for developers not familiar with say Lisp, Haskell, PureScript, Elm or OCaml.
   - And let's be honest, compared to say JavaScript these are ultra-niche.
   - So next to immutability and strict typing developers are also forced to know these and/or understand these ultra niche technologies.

---

## Gleam/2

### What sets Gleam apart

1. Average developer happiness matters:
   - The Gleam language is developed with great care limiting the languages' *strangeness-budget*.
   - Syntax appears to be familiar to JavaScript.
   - Not every feature one could think of or desire is implemented.
   - The language interface/surface is being kept small for this reason.
   - It should be easy to pick up.
   - Expressive and clear error messages.
   - Powerful type inference to get started or for the lazy (appears if types are optional or dynamic).
2. Compiles to targets Erlang and JavaScript.
   - Once there is more financial support the main developer would like to add C/native as a compile target.
3. The compiler is written in Rust:
   - Compiling Gleam is ultra snappy and at the same time yields compile time guarantuees.
   - Can be compiled via WASM within the browser - Gleam' playground uses this.
4. Interacts with Erlang/OTP, Browser-Javascript, NodeJS and possibly Deno.

---

## Gleam/3

<style>
img {
  height: 67%;
  width: auto;
}
</style>

<img src="/star-history.png" class="rounded drop-shadow-2xl" />

Source: [star-history.com](https://star-history.com/#gleam-lang/gleam&alpaca-lang/alpaca&hamler-lang/hamler&wende/elchemy&purerl/purerl&AbstractMachinesLab/caramel&lfe/lfe&bragful/ephp&rvirding/luerl).

---

## Gleam/4

**With all that being said, let's dive in a bit!**

---

## Gleam/5

### Demo time

Demo and this talk in available here: <https://github.com/inoas/gleam-elixir-phoenix-liveview-counter>.

Run at home? Make you have got Erlang, Elixir, Gleam and Rebar installed. See below for some instructions.

Run demo app via:

```sh
bin/dev/run && open http://localhost:4000
```

Run the slides via:

```sh
bin/dev/slides && open http://localhost:3030
```

&nbsp;
### Demo link

<mdi-arrow-right-thick /> <http://localhost:4000>

---

## Gleam/6

### How to install gleam

1. Install ASDF <https://asdf-vm.com/guide/getting-started.html>
   ```sh
   brew install asdf # Mac OS only, other instructions above
   ```
2. Install Erlang, NodeJS, Gleam
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

## Gleam/7

### Playtime

- Toying around together on <https://johndoneth.github.io/gleam-playground>.
- Caveat: Only one module, no dependencies except gleam's included prelude and `gleam_stdlib`.
- Going through some examples found here: <https://gleam.run/book/tour>.

---

## Gleam/8

### Playground Examples

- [Strings attached <mdi-open-in-new/>](https://johndoneth.github.io/gleam-playground/?s=JYWwDg9gTgLgBAcwDYFMCGID0wIChSSyKoaYDOMUwAdggPoBGArsEgCYpRxplxkP5w0eMnRYGwGHQpVagwiJJYoKMkyQxcuMEwZwAZtTgg0NABQBKOAG9ccOACIAEiiRIIcAGJQ01ANb6TLAAhA5wAD4AfHA4AHRgsjBI1Fr2ANrOru6OADSOAKJIwAAewFwOALp2EdH8sfpQECDSlDQIZNVRfAyxaGBgKNRsZg4AsigoMExgoRadtT0wEC2yCPMxEPGJyak23GRknPAA8n5mMm1WALxwADy3mW4eAOJKcIC8G4DVO6EAXEww%2BgAHJFItV7F0JFILrRYksVm1qgBfdYqNQaWJMagAdx8YBGDjmiKAA%3D%3D)
  - Strings and StringBuilder, there is also BitStrings
- [Very expressive <mdi-open-in-new/>](https://johndoneth.github.io/gleam-playground/?s=JYWwDg9gTgLgBAcwDYFMCGID0wIChSSyKobYB2M%2B408y6WAZkhGpQTcfZgM4xTBkEuXAzJwQrABYB9FAA8wUFN244ysuRjCoAFAEo4Ab1xwjcAIwA6AAxwA1JbgBWG3AC%2BcTI4BMrgD4AfHBMLDCWMBDSvPyCcIFwOJaKAjBIZCbOnmbm9hbucUEp4ZHRAggFCRBJManppobO%2FkEhrJZQEACuZAAm%2BQCkcN4VRRFRfGXDVckUabhuwqJwAEbMAMYA1hqKyqoQ6vJaugbGpqjwAG5oSB0oAFxwAEIQEEhwALxGGaamidO1OgAiASqbooOAwSRglYQDYAvRfb4AFiGdgsQ0wmDgAHEIMoEhQIODIXBzhBgN0EaYAGJXbhgjFwACS3GWKAmShgHSgZBQFNM8x%2BVVBSw6CB0l2uKHh8xEYlWaDpWyUKjUGkOKH0n1OKHgoIQSmU0lWKCQqg6LI%2B3gAzBl5XS4HqDdwjSazSyTt9pAkGA6UPqUIbjabgOa4AAeCwADjgAFoggCIoTVi9ugCEV7gD7HQHnUG3XAgt4hnGtd9TKVBJZk2R5TAdABtBPPAEAGjgAPbbYBkggMABAF14WWBZ7Y%2FH%2Faw0%2FzJtUUrMZYs0GQ9gBPECdZ0MLqrGCq%2BTbFV7NXgI6ls5wOTvOAAdgy55XV4AbHedXAl0etzXpMqOkh4B9RB0OQ2xXY4EUvAAqOAVwyNwgJAgx4hGEpxliJCphqedhDADolmCMQJAETUPQkCElR2PdNBPDUh2WNZNn3ZVdn2KjtBo20FRQcjDxY9V9Ayd8yDXDdpE%2FHdKIPZjjzY%2Fi3CAA)
  - Keywords: Expressions everywhere: Functions, anonymous functions, case statements, expression blocks
- [Lovely patterns <mdi-open-in-new/>](https://johndoneth.github.io/gleam-playground/?s=JYWwDg9gTgLgBAcwDYFMCGID0wIChSSyKobYB2MuuAZmXAMZoDOKA%2BmGjDClGayJ3oALVigAeGMKgAUASjgBvXHDip4YuAF44ARmWqU8AJ5a4AJn2MWcMQBo4JpSpU77OuAFoAfHABEAIwgYITg0KBRdX30Xe1ZPH18NYCZI6LhWN3i%2FE2TU53TYrN8yFGBgnjhcnSiVAF84AB8fHAA6ABMUfwBXBFxaqjAu%2FzgYIzAIgGFORX0pmGkyDBQALjgAZRgoYDIEe3ou7hKmJlWASQp7NAQVuHOYWT6qWgYuphgIEFZR8fZObl5%2BIIhHIZipMJg4ABBJBIODUYAoJBtFJgcIsCj6NQMabaOYLJarXwAMURwDEvj2BxQRxOcAAnAAGBmuULXVYAVgeKixeMWIBufJQlMOKGOqwyrJurHk2kYlBUrVR2xgSDI%2BP58nBfhJSDJUX0WoA8uUoHCEUiUsAEGRoCg2nB%2FCYmKj0G1tr1uYZsfBcZx1TdiaTycLqaLaYzmZc2XBOZivXirjdE%2FYWi0Zd79InGs0KC13qw3lsdtnKhAWkqKKqQVr2Y9cINhs8BNsQU5sSxflweHwBDBhKIJOAZFyXm8Pl8xmwOF2Ab3hHJ9AA5YBIR5AA%3D%3D%3D)
  - Keywords: Discards ands spreads
- [Pipe and capture <mdi-open-in-new/>](https://johndoneth.github.io/gleam-playground/?s=JYWwDg9gTgLgBAcwDYFMCGID0wIChSSyKobYB2M%2B408y6WAzjFMGQrrgGZlwMCuAI2ZoAxvAAUIVnxRkAJnDQAaXoOEALWQoEBKOAG9ccRXAC0cAbgC%2BHMILjc4INK3F7DxgIxwAPgD5VIShRGHEAJj1%2FOBwAOjkUAT4EOExMM08jOG8o%2FiCQ8QB9FQjfANj4xOTU9MzsgNzhMXCVAsiyiDiEpJS0jK9SwMbQhuDNeQAuOBKo8q6q3uiGODBgMBQFVhgIJ2ktFSgUGD4oMiW%2BrIGR%2FKkyGQmptuiOiu7q72AllbWNim2rsbk%2B0Ox1ONUy1QAkpw4DBNA4%2BGQxDgeAhgAA3WSLOAiCDgVAwFAqVhMdAKCDQsBoBgMVjJNBwNFoJAyaK%2FGFwzjAKBMXiQGAqWEoeGImDIrEoAAeKBEfAJCjQ8jgkrWYnWMO2ByOJxMnARSIgZHGmXxDKZLIAvHAAEQACRQSCQ2wA6tAkHIAIRW42HZYsCgFKlwS2OcSoDFIdyZYwhtBQBCR4yJuAAbStYftkytKnTSBUVpSijjmZUsYQAF1LsxaTEcYi0PAZh0wH6YEgyFHE6WOzZjD3TcyhVFm5sAwxxFbWJwIFadJkAHLAJDWXBAA%3D%3D%3D)
  - Keywords: Piping, capture symbol, complete functions assumed to return functions to push the pipe value into
- [Bonus: Racing without safety belts <mdi-open-in-new/>](https://johndoneth.github.io/gleam-playground/?s=JYWwDg9gTgLgBAcwDYFMCGID0wIChSSyKoaYBmSEaM%2B408y6WwAdjQfcU5gK5TC1CDEligoAzjyQ1cmTHAAqAC2Di4ZFnBQAPVTDWs4YgMYo2XDAH1xMACZJgAIzgA3FFHE5NaA2wB04gCOPGhillAQEDQacKww1sGhKOGRMAAU2gBccACSbACUcAC0AHxwAEoSUukAYpTUADRwAHLASIUA3rhwcNrdcAA%2BZXF%2BMBCWFFQ0PUPq9TABiWERUbgAvri4MUo%2BlsC2ZjDAxmhIe2wZ2XVThaVwAEKRSHBdPdpwALwfc1N%2Bpm2sBAZfLrTYxMbndJZODXai3MqVSTSNJ5GBNVrtF79E7iFBwHbiPYHNjHU6Q4FYno9BRQHh4u4AeQA1mlJtQ%2FBEeCxbMCQVSYadccUygBRKARKBpDF8uAbDZbTQQJmWaCWYxQHxKNJiJEwbKI6ppNDotr5eFwNCUi3iXFEZlpFynOmFb466r9R1IOmg3BgHjOGIgNCsNLmjFYzY9ORwEXaMAOYzAeA%2BW36fpyfqoeDvb4AFn6Kfc8Ht2hdsTYCRCy1SwILNqLcBLZYhcVrPRwfgOjh4QNLm3T8gACsAwChbNbU%2BIB%2F18zMyhoKa8qYW7SzS59y%2FEglXkisoTK3v0NnP1CxF%2F0eivi2vm%2BNW33%2BX0esfBsMIJ2UN2EP2o%2FIxQgIBYCAQGOCciynX8Z36WY4krJIUiiV84CVFUoDVDVxCUaCyhbcxZhQ1V1U1bDYnfLsex%2FFo2lBIA)
  - Keywords: assert, pipelines

---

## Closing words/1

### Is Gleam production ready?

To my knowledge the main author certainly thinks so. People are using it in production. In the end Gleam generated rather readable Erlang (or JavaScript).

### Anything bad?

- Complete exhaustiveness checks on `case` statements.
- The compiler, to be able to deal with broken/partial ASTs and still offer good help
  - Thus that we can have autosuggestions/completion and better IDE tooling.

<mdi-head-dots-horizontal /> To my knowledge, these features are on the core developer's lists.

---

## Closing words/2

### The state of matter

- The language is pretty stable:
  - The main author has stated that they intend to not break any language syntax or core language interfaces.
  - Syntax high-lightning and the first LSP is available.
  - Github officially supports the language.
- The eco-system needs help, libraries, more developers, and more users:
  - A lot of things already exist: HTTP1/2 servers, HTTP clients, JSON decoders, Protocol-Buffers, PostgreSQL client, Mustache and Matcha templating and many more.
  - For more see <https://github.com/gleam-lang/awesome-gleam>.

---

## Closing words/3

### Thanks & shout-outs

- Joe & Team for creating Erlang!
- José & Chris for creating Elixir, Phoenix & LiveView!
- Louis for creating Gleam!
- The Gleam community and especially *michallepicki*, *rattard* and *HarryET* for helping out!

---

## Closing words/4

### Become shiny

The Gleam community is very friendly, not snobbish at all, and welcomes developers of all trades and levels!

**<mdi-emoticon-excited /> Gleam needs you - Gleam wants you! You want Gleam - you need Gleam! <mdi-emoticon-excited />**

... and no, it is not going to replace Elixir anytime soon!

- Discord: <https://discord.gg/twY7ZhKTM3>
- GitHub Discussions: <https://github.com/gleam-lang/gleam/discussions>
- Gleam on the web: <https://gleam.run>
