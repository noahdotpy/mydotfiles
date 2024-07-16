# Nushell Config File

$env.config = {
  rm: {
      always_trash: true
    }
}

# TODO: Switch to `ugum choose` for choosing which option
# Container shortcuts
export def '@' [choice = "", params = ""] {
  let name = $choice
  if $name == "" {
    let name = (echo $"(distrobox list | tail -n +2 | cut -d '|' -f2)\n host" | fzf | xargs)
  }

  if $name == "host" {
    distrobox-host-exec $params
  } else {  
    distrobox-enter $name -- $params
  }
}

alias x = clear

alias dots = chezmoi
alias dotsa = chezmoi apply
alias image = rpm-ostree
alias g = git

export def e [params] {
    ^$"($env.EDITOR)" $params
}

kjv (^sort -R $"($env.HOME)/.local/share/zsh-bible/verses" | head -n 1) | cowsay | head -n -5 | lolcat -S 25

# TODO: Fix zoxide
# alias cd = z
# alias cdi = zi
# source ~/.cache/zoxide.nu