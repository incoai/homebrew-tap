# Inco AI Homebrew tap

```sh
brew install incoai/tap/splash
```

[Splash](https://github.com/incoai/splash) is Inco AI's open-source inference
engine for Apple silicon, built around the model. See the
[launch post](https://inco.ai/blog/splash/) for what it does and how it was
measured.

## The formula is generated

Do not hand-edit `Formula/splash.rb`. In `incoai/splash-dev`, `make package`
builds the release archive and `make package-bottle` adds the prebuilt bottle
to `dist/splash.rb`. Copy that generated formula here when publishing a release.

## Release checklist

1. In `incoai/splash-dev`, run `make package RELEASE_VERSION=<version>`, then
   `make package-bottle RELEASE_VERSION=<version>` and
   `make package-check RELEASE_VERSION=<version>`.
2. Publish the archive, bottle and checksums as a GitHub Release on the public
   mirror, `incoai/splash`, which is where the formula downloads from.
3. Copy `dist/splash.rb` to `Formula/splash.rb` here and merge the update.
4. On a clean machine: `brew install incoai/tap/splash && splash --version`.
5. Run `brew audit --strict --online incoai/tap/splash` before announcing.

Shell completion needs no extra step. The generated formula symlinks `_splash`
and `splash.bash` out of `libexec`, and because the whole tree is installed
there, the `models` helper still finds `official-models.txt` beside it.
