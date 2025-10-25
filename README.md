# Joker - Jokes, Trivia, Rolls, Custom Ready, Burns, Pickup Lines, & More in ESO!
Joker is a free community addon for [Elder Scrolls Online](https://www.elderscrollsonline.com), currently available for PC/Mac. A console port of Joker is planned for the future (WIP).

## Download
You can download Joker from the Releases page (for manual installation), or via ESOUI (also searchable via Minion). ESOUI also provides a manual download option.

- ESOUI: [Download Joker](https://www.esoui.com/downloads/info2329-Joker-JokesTriviaRollsCustomReadyBurnsPickupLinesampMore.html)
- Releases: [Download Joker](../../releases)

#### Current Release: **v8.6.5** (ESO-101048)

## About
Best enjoyed with Skooma, Joker offers a collection of various jokes, riddles, fun utilities & other amusing pop-culture references - all readily available ingame for your leisurely chatting pleasure!

Joker can send you messages periodically (such as every few zones), or you can run commands directly to get a joke, trivia, roll, custom ready check, burn, pickup line, and much more!

--

> **24 Oct 2025**: There is a known issue with how Minion 3 and 4 handle the installation of Joker 8.4.0. I'm working on adjustments to work around this issue (hopefully this weekend), but in the meantime installing manually or via other addon managers is recommended. This is not an issue with the addon itself, but specifically with how Minion attempts to unpack the zip archives.

> **Latest Feature Release: v8.2.1**: Try out the new `/trivia` command, which includes ~75 various Q&A and 'did you know'-style tidbits about ESO. Grill your friends or learn something new :)

## Table of Contents

- [Dependencies](#dependencies)
- [Commands](#commands)
- [Build](#build)
- [Development](#development)
- [Update Roadmap](#update-roadmap)
- [Contributing](#contributing)
- [Sourcing & Citations](#sourcing)
- [License](#license)
- [Disclaimer](#disclaimer)


## Dependencies
The following libraries are presently required for Joker to function properly. Otherwise, Joker is compatible with all live versions of ESO.
- `LibAddonMenu-2.0`

### 'Outdated Version' Warnings
Depending on whether or not I'm actively playing at a given time, I may not have updated the addon to explicitly state it supports the latest version of the game. Joker should still be compatibile with newer versions of ESO, even if it shows outdated - functionally it's very simple and the APIs it's using are unlikely to change significantly or often. You should be able to safely use Joker and ignore the outdated version warnings, but if you run into issues, please let me know!

## Commands
> *Note*: Due to ESO's UI and ToS restrictions, addons are not allowed to send chat messages on your behalf. As a result, when you run a command, Joker generates the jokes/messages and puts them in your active chatbox - just hit enter to send!

### Settings UI/Help
- `/joker`: Shows Joker settings & help.

### Jokes
- `/joke [filter]`: Picks a random joke and adds  - just hit enter to send. Type `/joke text` to pick a random joke related to your text (for example, `/joke argonian` would show a random joke related to Argonians).
- `/joke-eso` (or `/eso`): Adds a random ESO-related joke 
- `/joke-dad` (or `/dad`): Adds a random Dad joke 
- `/joke-lotr` (or `/lotr`): Adds a random Lord of the Rings-related joke 
- `/joke-got`: Adds a random Game of Thrones joke 
- `/joke-pokemon` (or `/pokemon`): Adds a random Pokemon joke 
- `/joke-edgy`: adds a random edgy joke to your chatbox (added by popular request). Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Please be considerate with your usage.
- `/joke-norris` (or `/norris`): Add a random Chuck Norris joke .
- `/joke-pickup [target]` (or `/pickup`): Add a random cheesy/cute pickup line to your chatbox. 

### ESO Trivia, Shower Thoughts, and Cat Facts
- `/trivia`: Get a random tidbit of ESO trivia! Grill you friends or learn something new!
- `/joke-wisdom` (or `/wisdom`): Adds a random tidbit of wisdom or shower thought (though sometimes a bit sarcastic)
- `/catfact`: Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!

### Pickup Lines and Burns
> *Note*: Pickup lines are not always appropriate for all audiences and were intended primarily for use among friends. Please be considerate with your usage.

> **Pro Tip**: Include a target (like a name) to have Joker automatically make them the subject of the pickup line!

- `/pickup-hp [target]`: Add a random Harry Potter pickup line to your chatbox. 
- `/pickup-poke [target]`: Add a random Pokemon pickup line to your chatbox. 
- `/pickup-xxx [target]`: Add a random adult/r-rated pickup line to your chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. 
- `/joke-burn [target]` (or `/burn`): Add a random burn to your chatbox.

### Custom Ready Checks (and Votes)!
A crowd-favorite and something many players didn't know you could do! With Joker, run `/ready` to trigger a random meme-y ready check for your group, or specify your own!

#### Basic Usage
- `/ready`: Picks a random Joker-curated ready check prompt, visible to your group. They'll see a prompt (for example: "Do a barrel roll?") and be able to mark 'Yes' or 'No'.
- `/ready [text]`: Send a custom ready check with your own message! Users can then respond with 'Yes' or 'No'.
- Example: `/ready Is the cake a lie?` (Users will see a prompt on their screen/chat with "Is the cake a lie?", and be able to mark 'Yes' or 'No')

#### Advanced Usage (Voting!)
Add 'unan', 'simple', or 'super' right before your prompt to specify the type of ready check you want. This will change the required percentage of players to pass the ready check, effectively giving you a party-based voting system!

- Example: `/ready unan Is the cake a lie?` (100% required to pass)
- Example: `/ready simple Should we blame the healers?` (51% required to pass)
- Example: `/ready super Should we take a 5 min break?` (67% required to pass)

### Rolls, Choose, & Raffles
As noted above, chat commands can't send messages to others on your behalf. The commands below show in your chat to you, and go to your chatbox - just hit enter to send!

#### Roll: Basic Usage
- `/roll` RNG roll. By default, rolls between 0 and 10, and posts the result in chat
- `/roll 100` Same as above, but adjusts the ceiling. This example would roll between 0 and 100, and post the result to your chatbox.

#### Roll: Advanced Usage
- `/roll [floor],[ceiling],[prize]`: Including a single integer will roll between 0 and the int. Including two ints (comma-delimited) will roll between the two numbers. You may optionally also include a prize/memo (supports item links) - which will also post the roll in chat for you.

- Constrain floor & ceiling: `/roll 5,100` (rolls between 5 and 100, and posts the result in chat)
- Constrain and add a memo: `/roll 5,100,A nice sword` (rolls between 5 and 100, and posts the result in chat)

#### Choose
Similar to /roll, chooses randomly among given options (separated by space) - this can be useful for choosing players (without having to track everyone's numbers like you would with a roll), or RNG choosing among various options/items.

Basic Usage: `/choose [options]` (separated by space)
Example: `/choose red green blue` (chooses randomly among the three colors)

For even more efficiency, you can use `/choose party` to randomly choose a winner from your party (up to 24 members)! When using `/choose party`, you can optionally add a prize (supports item links) - which will also post the winner and prize in your chatbox - just hit enter to send!

Examples:
- `/choose party` Read your list of party members and choose a "winner" from them.
- `/choose party [prize]` Read your list of party members and choose a winner, attaching the prize or memo to the winner in chat.

### Other Fun Commands
- `/8ball`: Undecided? Get advice from the sage 8ball.
- `/twister`: Get a random tongue twister! Can you say it 3 times fast?
- `/curse`: Exasperated? Throw out a /curse (or '/curse Mark' because Mark deserves it!). Curses are meant to be more amusing than anything, and are SFW - all curses are pulled from Elder Scrolls, Star Wars & Trek, LotR, other nerdy series, and vintage pop culture.

### Utility Commands
These are some other helpful utilities that can be useful in various situations (but that don't really deserve their own addon)
- `/rl`: Shorthand for /reloadui. It ... reloads the UI.

## Build

### Local Building

The build process uses a cross-platform Node.js script that creates zip files compatible with (hopefully)all addon managers (including Minion):

```bash
# Install dependencies
npm install

# Build the addon
npm run build
```

This creates a zip file at `dist/<version>/joker-<version>.zip` with the proper folder structure (`Joker/*`) required by ESO addon managers.

**Key features:**
- ✅ Cross-platform compatible (Windows, macOS, Linux) without solely depending on OS-specific archiving tools
- ✅ Works with Minion and other ESO addon managers

**What's included:** Only the files ESO needs to run the addon - `.lua` files, `.xml` files, `Joker.txt` manifest, translations (`i18n/`), joke content (`jokes/`), and settings (`options/`) are intended to be included in the built package. Documentation, build scripts, and development files are excluded.

### Automated Releases

#### Quick Release (Recommended)

Use the `prep-release` script to automate the entire release process:

```bash
# One command to update version, commit, tag, and push
npm run prep-release -- 8.5.0 --push
```

**Note:** The `--` is required when using `npm run` to pass arguments to the script.

This will:
1. Update version in all required files
2. Commit changes with "Bump version to 8.5.0"
3. Create and push git tag `v8.5.0`
4. Trigger GitHub Actions to build and release

#### Step-by-Step Release

For more control, use the script in stages:

```bash
# Update version files only (review first)
npm run prep-release -- 8.5.0

# Commit the changes
npm run prep-release -- 8.5.0 --commit

# Create tag and push (triggers release)
npm run prep-release -- 8.5.0 --push
```

Alternatively, run the script directly (no `--` needed):

```bash
node prep-release.js 8.5.0 --push
```

#### prep-release Options

```bash
npm run prep-release -- <version> [options]
# or
node prep-release.js <version> [options]

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
- **[Added v2.2.0]** Popular TV show references & jokes (GoT, Billions, The Walking Dead, Grey's Anatomy, etc - always taking requests),
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

This project is licensed under a custom **Source Available** license;
see the [LICENSE](LICENSE) file for details.

## DISCLAIMER: 

This Add-on is not created by, affiliated with or sponsored by ZeniMax
Media Inc. or its affiliates. Trademarks are the property of their respective owners.

You can read the official ESO Add-on Terms at:
https://account.elderscrollsonline.com/add-on-terms
