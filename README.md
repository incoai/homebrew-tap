# Inco AI Homebrew tap

Formulae for Inco AI's open-source tools.

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

## Splash service

For existing installations, update the tap and run `brew reinstall splash` first.

Run without `sudo`; stop any foreground Splash server first:

```sh
brew services start splash
brew services stop splash
```

Defaults below; to override, create `$(brew --prefix)/etc/splash-service.conf`:

```sh
SPLASH_MODEL=incoai/Qwen3.8-27B-Splash
SPLASH_PORT=8000
```

Apply changes with `brew services restart splash`. The first start downloads
the model if needed.

Logs: `$(brew --prefix)/var/log/splash.log`.

Report problems with a tool in its own repository. This tap only carries the
formulae.
