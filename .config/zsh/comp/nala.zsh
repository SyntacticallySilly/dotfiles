#compdef nala

autoload -U is-at-least

_nala_completion() {
  eval $(env _TYPER_COMPLETE_ARGS="${words[1,$CURRENT]}" _NALA_COMPLETE=complete_zsh nala)
}

compdef _nala_completion nala
#compdef nala

_nala_completion() {
  eval $(env _TYPER_COMPLETE_ARGS="${words[1,$CURRENT]}" _NALA_COMPLETE=complete_zsh nala)
}

compdef _nala_completion nala
