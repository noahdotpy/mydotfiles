<div align="center">

#### My dotfiles managed with Chezmoi :house_with_garden: and Nix :snowflake:&nbsp;


## :warning:&nbsp; WARNING :warning:&nbsp;

Please note that this is my own personal dotfiles.
Stuff may change without further notice.
</div>

## Use
```bash
chezmoi init noahdotpy/mydotfiles --apply
```
```bash
home-manager switch --flake ~/.local/share/chezmoi
```

## Directory Structure
- `chezmoi`: chezmoi source
- `homemanager`: homemanager nix files

Nix homemanager is mostly only used to declare which packages I want. The reason I use chezmoi as well is because I like the experience of adding new files, changing existing files, etc.
