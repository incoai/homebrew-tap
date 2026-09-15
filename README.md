# Inco AI Homebrew tap

```sh
brew install incoai/tap/splash
```

[Splash](https://github.com/incoai/splash) is Inco AI's inference engine for
Apple silicon. See the [launch post](https://inco.ai/blog/splash/) for what it
does and how it was measured.

## Status

This tap is **not yet functional**. `Formula/splash.rb` is scaffolding — the
`version`, `url` and `sha256` fields are placeholders, because `incoai/splash`
currently has no tags and no releases to point at.

## Release checklist

Before `brew install incoai/tap/splash` will work:

1. Tag a release on `incoai/splash` and attach a `splash-darwin-arm64.tar.gz`
   built for Apple GPU family 9+ (M3 and newer).
2. Decide whether the tarball ships the shell completions from
   `install/completions`, and uncomment the matching lines in the formula.
3. Fill in `version`, `url` and `sha256` from the release asset.
4. Make `incoai/splash` public — Homebrew must be able to fetch the asset
   anonymously.
5. Make this tap public.
6. Verify end to end on a clean machine:
   `brew tap incoai/tap && brew install splash && splash --version`
7. `brew audit --strict --online incoai/tap/splash` before announcing.

Note that the model package the formula's caveats mention
(`incoai/Qwen3.8-27B-Splash`) is currently published as
`incoai-internal/Qwen3.8-27B-Splash`; these need to agree before launch.
