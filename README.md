# Joker-ESO
A community addon for [Elder Scrolls Online](https://www.elderscrollsonline.com)

### [Download here](https://www.esoui.com/downloads/info2329-Joker-JokesandOtherLeisurelyTomfoo....html) (also available via Minion)

#### Current Release: **v1.0.0** (10000)

> Best enjoyed with Skooma, Joker offers a collection of various jokes, riddles, & other amusing pop-culture references both in and out of Tamriel. 

> Latest release (v1.1.0) contains Norris & ESO jokes (as a test & proof-of-concept; this is my first ESO addon), but more content coming super soon!

## Table of Contents

- [Purpose](#purpose)
- [Dependencies](#dependencies)
- [Commands](#commands)
- [Update Roadmap](#update-roadmap)
- [Contributing](#contributing)
- [Sourcing](#sourcing)
- [License](#license)

## Purpose
Includes 545+ jokes and pop-culture references, instantly available ingame for your leisurely chatting pleasure!

## Dependencies
The following libraries are presently required for Joker to function properly. Otherwise, Joker is compatible with all live versions of ESO, including (probably) the upcoming Elsweyr chapter. Both are packaged within. 
- `LibAddonMenu-2.0`
- `LibStub`

## Commands
- **/joker**: Shows Joker settings & help.
- **/joke**: Picks a random joke and adds to your active chatbox.
- **/eso**: Adds a random ESO-related joke to your active chatbox
- **/norris**: Add a random Chuck Norris joke to your active chatbox.
- **/norris me**: Add a random joke to your chatbox, with *you* as the subject!
- **/norris *target***: Add a random joke to your chatbox, with `target` as the subject
- More soon!

## Build
v1.0.1: If you have WinRAR & Windows, there are now two scripts in package.json that semi-automate the build packaging. You should create a /dist dir in main dir, then run one of the below:
- `build` Zips up the whole repo (excluding .git/, dist/, & .vscode/) into the appropriately versioned folder in /dist/ (based on version in package.json). The resulting Joker.zip is ready to upload to esoui.
- `build-new` creates a new folder in /dist/ matching the version number in package.json, then zips up the whole repo (excluding .git/, dist/, & .vscode/). The resulting Joker.zip is ready to upload to esoui.


## Update Roadmap
Always accepting requests, suggestions, etc. Here are a few things currently on the roadmap:

- Popular TV show references & jokes (GoT, Billions, The Walking Dead, Grey's Anatomy, etc etc etc),
- Fun riddles and mindtwisters,
- Add GUI options in Addon settings to enable/disable 

## Contributing

#### Maintainers:
- [@adefee](https://github.com/adefee)

#### Contributing

See [package.json](package.json)!

PRs accepted.

### Big thanks to:

- [@Phuein](https://www.esoui.com/forums/member.php?action=getinfo&userid=38690): NewAddon boilerplate made it super-easy to get started in minutes :)
- [@Dolgubon](https://www.esoui.com/forums/member.php?action=getinfo&userid=23366): Early help, tips, cleanup :)

## Sourcing
Jokes, riddles, memes, etc were (other than my own content) sourced from the below sources:
- ESO Jokes: https://github.com/esoui/lexicon/blob/master/lexicon/joke/joke.go
- Norris Jokes: http://www.icndb.com/api/

## License

MIT
