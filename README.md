# 4BMtolobPL Tap

## How do I install these formulae and casks?

`brew install 4bmtolobpl/tap/<formula>`

`brew install --cask 4bmtolobpl/tap/<cask>`

Or `brew tap 4bmtolobpl/tap` and then `brew install <formula>` / `brew install --cask <cask>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "4bmtolobpl/tap"
brew "<formula>"
cask "<cask>"
```

## Available

| Name | Type | Description |
| --- | --- | --- |
| [keyclean](Formula/keyclean.rb) | formula | Small utility to clean your Macbook keyboard |
| [kommit](Formula/kommit.rb) | formula | CLI tool using AI to generate Conventional Commits from Git diffs |
| [khannel](https://github.com/4BMtolobPL/khannel) | cask | IRC client built with GPUI (Apple Silicon) |

`Casks/khannel.rb` is updated automatically when a khannel release is published.
khannel is not notarized by Apple, so allow its first launch in
System Settings > Privacy & Security > "Open Anyway".

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
