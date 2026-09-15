# Inco AI Homebrew tap

```sh
brew install incoai/tap/splash
```

[Splash](https://github.com/incoai/splash) is Inco AI's inference engine for
Apple silicon. See the [launch post](https://inco.ai/blog/splash/) for what it
does and how it was measured.

## Status

Not yet installable. `Formula/splash.rb` carries placeholder `url`, `version`
and `sha256` values, because `incoai/splash` has no releases to point at.

## The formula is generated

Do not hand-edit `Formula/splash.rb`. `dev/tools/package.py` in `incoai/splash`
builds the release archive and writes the matching formula to `dist/splash.rb`;
releasing means copying that file over this one. Hand edits will be silently
overwritten at the next release.

## Release checklist

1. In `incoai/splash`, run `dev/tools/package.py` to build the archive and
   `dist/splash.rb`.
2. Publish the archive as a release asset on `incoai/splash`.
3. Copy `dist/splash.rb` to `Formula/splash.rb` here.
4. Make `incoai/splash` public. Homebrew fetches release assets anonymously, so
   this has to happen before the formula can work for anyone.
5. Make this tap public.
6. On a clean machine: `brew tap incoai/tap && brew install splash && splash --version`.
7. `brew audit --strict --online incoai/tap/splash` before announcing.

Shell completion needs no extra step — the generated formula symlinks `_splash`
and `splash.bash` out of `libexec`, and because the whole tree is installed
there, the `models` helper still finds `official-models.txt` beside it.
