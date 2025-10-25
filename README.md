# Joker-ESO
A community addon for [Elder Scrolls Online](https://www.elderscrollsonline.com)

### [Download live version on ESOUI](https://www.esoui.com/downloads/info2329-Joker-JokesandOtherLeisurelyTomfoo....html) (also available via Minion)

#### Current Branch Release: **v8.5.0** (ESO-101048)

> Best enjoyed with Skooma, Joker offers a collection of various jokes, riddles, fun utilities & other amusing pop-culture references - all readily available ingame for your leisurely chatting pleasure! 

> Version 4.X.X is a major milestone release, with the purpose of offering a simpler and more aesthetically pleasing settings UI, greater customization and control (including a simplified manner with which to add your own jokes, riddles, and more!), removal of extra dependencies (where possible), and possibly an auto-update mechanism!

## Table of Contents

- [Dependencies](#dependencies)
- [Commands](#commands)
- [Update Roadmap](#update-roadmap)
- [Contributing](#contributing)
- [Sourcing](#sourcing)
- [License](#license)


## Dependencies
The following libraries are presently required for Joker to function properly. Otherwise, Joker is compatible with all live versions of ESO.
- `LibAddonMenu-2.0`

### 'Outdated Version' Warnings
Depending on whether or not I'm actively playing at a given time, I may not have updated the addon to explicitly state it supports the latest version of the game. Joker should still be compatibile with newer versions of ESO, even if it shows outdated - functionally it's very simple and the APIs it's using are unlikely to change significantly or often. You should be able to safely use Joker and ignore the outdated version warnings, but if you run into issues, please let me know!

## Commands
- **/joker**: Shows Joker settings & help.
- **/joke *filter***: Picks a random joke and adds to your active chatbox - just hit enter to send. Type '/joke text' to pick a random joke related to your text (for example, /joke argonian would show a random joke related to Argonians).
- **/joke-eso** (or **/eso**): Adds a random ESO-related joke to your active chatbox
- **/joke-dad** (or **/dad**): Adds a random Dad joke to your active chatbox
- **/joke-got**: Adds a random Game of Thrones joke to your active chatbox
- **/joke-wisdom** (or **/wisdom**): Adds a random wisdom tidbit or shower thought to your active chatbox
- **/joke-pokemon** (or **/pokemon**): Adds a random Pokemon joke to your active chatbox
- **/joke-edgy**: adds a random edgy joke to your chatbox (added by popular request). Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Please be considerate with your usage.
- **/joke-norris** (or **/norris**): Add a random Chuck Norris joke to your active chatbox.
- **/joke-pickup *target*** (or /pickup): Add a random cheesy/cute pickup line to your chatbox. If you include a name (target), it will address it to them for you!
- **/pickup-hp *target***: Add a random Harry Potter pickup line to your chatbox. If you include a name (target), it will address it to them for you!
- **/pickup-poke *target***: Add a random Pokemon pickup line to your chatbox. If you include a name (target), it will address it to them for you!
- **/pickup-xxx *target***: Add a random adult/r-rated pickup line to your chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. If you include a name (target), it will address it to them for you!
- **/joke-burn *target*** (or **/burn**): Add a random burn to your chatbox. If you include a name (target), it will address it to them for you!
- **/8ball**: Undecided? Get advice from the sage 8ball.
- **/twister**: Get a random tongue twister! Can you say it 3 times fast?
- **/catfact**: Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!
- **/curse**: Exasperated? Throw out a /curse (or '/curse Mark' because Mark deserves it!). Curses are meant to be more amusing than anything, and are SFW - all curses are pulled from Elder Scrolls, Star Wars & Trek, LotR, other nerdy series, and vintage pop culture.
- **/ready <text>**: Ready checks, but funnier & faster to type! Optionally add your own custom prompt instead of a random witty one!
- And other helpful utilities, like:
  - **/roll <floor>,<ceiling>,<prize>**: RNG roll. By default, rolls between 1 and 10. Including a single integer will roll between 0 and the int. Including two ints (comma-delim) will roll between the two numbers. You may optionally also include a prize/memo (supports item links) - which will also post the roll in chat for you.
  - **/choose <options>** (or **/choose party <prize>**): Similar to /roll, chooses randomly among given options (separated by space). You may instead use "/choose party" to randomly choose a winner from your party (up to 24 members) - with the option to assign a prize (supports item links).
  - **/rl**: Shorthand for /reloadui

## Build

### Local Building

The build process uses a cross-platform Node.js script that creates standard-compliant zip files compatible with all addon managers (including Minion):

```bash
# Install dependencies
npm install

# Build the addon
npm run build
```

This creates a zip file at `dist/<version>/joker-<version>.zip` with the proper folder structure (`Joker/*`) required by ESO addon managers.

**Key features:**
- ✅ Cross-platform compatible (Windows, macOS, Linux)
- ✅ Uses standard deflate compression for maximum compatibility
- ✅ Works with Minion and other ESO addon managers

### Automated Releases

#### Quick Release (Recommended)

Use the `prep-release` script to automate the entire release process:

```bash
# One command to update version, commit, tag, and push
npm run prep-release 8.5.0 --push
```

This will:
1. Update version in all required files
2. Commit changes with "Bump version to 8.5.0"
3. Create and push git tag `v8.5.0`
4. Trigger GitHub Actions to build and release

#### Step-by-Step Release

For more control, use the script in stages:

```bash
# Update version files only (review first)
npm run prep-release 8.5.0

# Commit the changes
npm run prep-release 8.5.0 --commit

# Create tag and push (triggers release)
npm run prep-release 8.5.0 --push
```

#### prep-release Options

```bash
npm run prep-release <version> [options]

Options:
  --commit    Commit the version changes
  --tag       Create git tag (implies --commit)
  --push      Push to remote (implies --tag and --commit)
  --help      Show help message
```

#### GitHub Actions Workflow

Once a version tag is pushed, GitHub Actions automatically:
- Builds the addon on Ubuntu runners
- Creates a GitHub release
- Attaches the zip file as a release asset
- Generates release notes with installation instructions

You can also manually trigger a release from the [Actions tab](../../actions/workflows/release.yml) in GitHub.

### Version Management

The `prep-release` script automatically updates all version files. If you need to update manually, change these files:
- `package.json` - Main version source (e.g., `"version": "8.5.0"`)
- `Joker.txt` - Both `Version` and `AddOnVersion` fields
- `variables.lua` - `version` and `versionESO` constants
- `README.md` - Current branch release badge

**Note:** `AddOnVersion` / `versionESO` is calculated as: `MAJOR*100000 + MINOR*1000 + PATCH*100`
- Example: Version `8.4.0` → `804000`

## Development

### Code Structure

The addon is organized into several key files:
- **Joker.lua**: Main addon file with initialization, runtime, and core functions
- **Joker-Util.lua**: Utility functions (isEmpty, setContains, colorize, etc.)
- **Joker-Data.lua**: Data operations (joke retrieval, random selection, 8ball, ready checks, etc.)
- **variables.lua**: Default values and configuration
- **Settings.lua**: LibAddonMenu integration for settings UI
- **Joker.txt**: Manifest file that defines load order

### Adding Version Migrations

When you need to add a migration for a new version (e.g., to update saved variables or migrate data):

1. **Add version constant** at the top of `Joker.lua` in the Constants section:
   ```lua
   local VERSION_X_Y_Z = xyz000  -- e.g., VERSION_5_0_0 = 500000
   ```

2. **Create a migration function** in the "Version Migration Functions" section:
   ```lua
   -- migrate_to_X_Y_Z()
   -- Migration; Description of what changed in version X.Y.Z
   local function migrate_to_X_Y_Z()
     debugLog('Housekeeping for update to version X.Y.Z')
     -- ... your migration logic here ...
     Joker.saved.internal.lastUpdate = VERSION_X_Y_Z
   end
   ```

3. **Add the migration call** in `runtime_updates()`:
   ```lua
   if oldVersion < VERSION_X_Y_Z then
     migrate_to_X_Y_Z()
   end
   ```

**Notes:**
- Migrations run in order from oldest to newest
- Each migration should update `Joker.saved.internal.lastUpdate` to its version number
- Use `debugLog()` for any debug messages (automatically checks if debug mode is enabled)
- Migrations should be idempotent when possible

### Code Conventions

- **Function Naming**:
  - `local function snake_case()` for local/private runtime functions
  - `function Joker.PascalCase()` or `function Data.PascalCase()` for public API functions
  
- **Constants**: Define at the top of files using SCREAMING_SNAKE_CASE:
  ```lua
  local ENABLED = 1
  local DISABLED = 0
  ```

- **Debug Output**: Use `debugLog(message)` instead of checking `showDebug` manually:
  ```lua
  debugLog('Your debug message here')  -- Automatically prefixes with "Joker: "
  ```

## Update Roadmap
Always accepting requests, suggestions, etc. Here are a few things currently on the roadmap:

- **[Added v2.0.0]**: Hide jokes you've already seen,
- **[Added v2.0.0]**: Custom ready checks,
- **[Added v1.2.1]**: Magic 8 Ball,
- **[Added v2.0.4]**: Fun & customizable burns,
- **[Added v2.0.3]**: Cheesy, customizable pickup lines,
- **[Added v4.0.0]**: Add GUI options in Addon settings
- **[Added v4.0.0]**: Add filters to /joke (e.g. '/joke argonian' to pull a random joke about an Argonian)
- MOAR ESO jokes, quotes, & canon references (more always being added)
- **[Added v4.0.0]**: Add your own jokes (locally),
- Automated submission of jokes to be included in the addon for everyone,
- **[Added v2.3.0]**: Raffle: Randomly pick from pool of users,
- **[Added v2.2.0]**Popular TV show references & jokes (GoT, Billions, The Walking Dead, Grey's Anatomy, etc - always taking requests),
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

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

DISCLAIMER: 

This Add-on is not created by, affiliated with or sponsored by ZeniMax
Media Inc. or its affiliates. The Elder Scrolls® and related logos are
registered trademarks or trademarks of ZeniMax Media Inc. in the United
States and/or other countries. All rights reserved.

You can read the full terms at:
https://account.elderscrollsonline.com/add-on-terms
