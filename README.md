# Joker-ESO
A community addon for [Elder Scrolls Online](https://www.elderscrollsonline.com)

### [Download here](https://www.esoui.com/downloads/info2329-Joker-JokesandOtherLeisurelyTomfoo....html) (also available via Minion)

#### Current Release: **v2.0.6** (200060)

> Best enjoyed with Skooma, Joker offers a collection of various jokes, riddles, fun utilities & other amusing pop-culture references - all readily available ingame for your leisurely chatting pleasure! 

> Latest release contains a growing assortment of Chuck Norris, ESO-related, Dad, and Edgy jokes (plus some sarcastic tidbits of wisdom), with more content coming super soon!

## Table of Contents

- [Dependencies](#dependencies)
- [Commands](#commands)
- [Update Roadmap](#update-roadmap)
- [Contributing](#contributing)
- [Sourcing](#sourcing)
- [License](#license)


## Dependencies
The following libraries are presently required for Joker to function properly. Otherwise, Joker is compatible with all live versions of ESO, including (probably) the upcoming Elsweyr chapter. Both are packaged within. 
- `LibAddonMenu-2.0`
- `LibStub`

## Commands
- **/joker**: Shows Joker settings & help.
- **/joke**: Picks a random joke and adds to your active chatbox. Random pool does not include Edgy jokes or pickup lines.
- **/joke-eso**: Adds a random ESO-related joke to your active chatbox
- **/joke-dad** (or **/dad**): Adds a random Dad joke to your active chatbox
- **/joke-got**: Adds a random Game of Thrones joke to your active chatbox
- **/joke-wisdom** (or **/wisdom**): Adds a random tidbit of wisdom (though sometimes a bit sarcastic) to your active chatbox
- **/joke-edgy**: adds a random edgy joke to your chatbox (added by popular request). Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Please be considerate with your usage.
- **/joke-norris** (or **/norris**): Add a random Chuck Norris joke to your active chatbox.
- **/norris me**: Add a random joke to your chatbox, with *you* as the subject!
- **/norris *target***: Add a random joke to your chatbox, with `target` as the subject
- **/joke-pickup *target*** (or /pickup): Add a random cheesy/cute pickup line to your chatbox. If you include a name (target), it will address it to them for you!
- **/pickup-hp *target***: Add a random Harry Potter pickup line to your chatbox. If you include a name (target), it will address it to them for you!
- **/pickup-xxx *target***: Add a random adult/r-rated pickup line to your chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. If you include a name (target), it will address it to them for you!
- **/joke-burn *target*** (or **/burn**): Add a random burn to your chatbox. If you include a name (target), it will address it to them for you!
- **/8ball**: Undecided? Get advice from the sage 8ball.
- **/twister**: Get a random tongue twister! Can you say it 3 times fast?
- **/catfact**: Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!
- **/ready <text>**: Ready checks, but funnier & faster to type! Optionally add your own custom prompt instead of a random witty one!
- And other helpful utilities, like:
  - **/rl**: Shorthand for /reloadui

## Build
v1.0.1: If you have WinRAR & Windows, there are now two scripts in package.json that semi-automate the build packaging. You should create a /dist dir in main dir, then run one of the below:
- `build` Zips up the whole repo (excluding .git/, dist/, & .vscode/) into the appropriately versioned folder in /dist/ (based on version in package.json). The resulting Joker.zip is ready to upload to esoui.
- `build-new` creates a new folder in /dist/ matching the version number in package.json, then zips up the whole repo (excluding .git/, dist/, & .vscode/). The resulting Joker.zip is ready to upload to esoui.


## Update Roadmap
Always accepting requests, suggestions, etc. Here are a few things currently on the roadmap:

- **[Added v2.0.0]**: Hide jokes you've already seen,
- **[Added v2.0.0]**: Custom ready checks,
- **[Added v1.2.1]**: Magic 8 Ball,
- **[Added v2.0.4]**: Fun & customizable burns,
- **[Added v2.0.3]**: Cheesy, customizable pickup lines,
- **[In Progress]**: Add GUI options in Addon settings
- **[In Progress]**: Add filters to /joke (e.g. '/joke argonian' to pull a random joke about an Argonian)
- MOAR ESO jokes, quotes, & canon references (more always being added)
- Add your own jokes (locally),
- Automated submission of jokes to be included in the addon for everyone,
- Raffle: Randomly pick from pool of users,
- Popular TV show references & jokes (GoT, Billions, The Walking Dead, Grey's Anatomy, etc - always taking requests),
- **[In Progress, Partially Added v2.0.3]**: Fun riddles and mindtwisters (including interactive)
- Other fun (and maybe a little useful) utility commands,
- ... and lots of other stuff even further in the future (plus any requests from users)


## Contributing

#### Maintainers:
- [@adefee](https://github.com/adefee)

#### Contributing

See [package.json](package.json)!

PRs accepted.

### Big thanks to:

- [@Phuein](https://www.esoui.com/forums/member.php?action=getinfo&userid=38690): NewAddon boilerplate made it super-easy to get started in minutes :)
- [@Dolgubon](https://www.esoui.com/forums/member.php?action=getinfo&userid=23366): Early help, tips, cleanup :)
- [@A'Merri and @Harvspecial]: QA & Testing, thanks bunches <3

## Sourcing
Jokes, riddles, memes, etc were (other than my own content or content received directly from users/contributors) obtained from the below sources:
- ESO Jokes: https://github.com/esoui/lexicon/blob/master/lexicon/joke/joke.go
- Norris Jokes: http://www.icndb.com/api/, Reddit
- Dad Jokes: https://icanhazdadjoke.com, Github@15Dkatz/official_joke_api, Reddit Search, Reader's Digest
- Edgy/Explicit Jokes: Reddit Search
- Wisdom: Reader's Digest, Pinterest Search, Github@sarah256/fortune-api
- Other, General: Reddit Search, Google Search


If you own the intellectual property over any of the above brands, web properties, or any jokes/content included in this addon, please contact me via Github, or directly via email (me@andrewdefee.com) with your name, company and country of incorporation (if applicable), a clearly defined list of infringing content, and proof of ownership (or rights to claim on behalf of owner). I'll immediately comply with all such requests, and remove infringing content from any future updates to the Addon.

## License

MIT
