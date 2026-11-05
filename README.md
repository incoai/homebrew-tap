# Inco AI Homebrew tap

Formulae and casks for Inco AI's open-source tools.

## Install

```sh
brew install incoai/tap/<formula>
```

Or `brew tap incoai/tap` once, then `brew install <formula>`. In a `Brewfile`:

```ruby
tap "incoai/tap"
brew "<formula>"
```

Upgrade with `brew upgrade <formula>` and remove with `brew uninstall <formula>`.

## Formulae

| Formula | What it is | Requirements |
| --- | --- | --- |
| `splash` | Local inference engine for Apple silicon, built around the model. [Repository](https://github.com/incoai/splash) · [Launch post](https://inco.ai/blog/splash/) | M3 or newer Mac, macOS 26.4 or later, 36 GB of unified memory |

## Casks

| Cask | What it is | Requirements |
| --- | --- | --- |
| `splash-app` | The Splash desktop app. [Repository](https://github.com/incoai/splash) | M3 or newer Mac, macOS 26.4 or later |

```sh
brew install --cask incoai/tap/splash-app
```

Report problems with a tool in its own repository. This tap only carries the
formulae and casks.
