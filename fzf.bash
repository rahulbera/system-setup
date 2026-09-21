# Setup fzf
# ---------
# Ensure the newer (vim-plugin) fzf is FIRST on PATH, so `fzf --bash` below
# doesn't run an older system fzf (0.44) that lacks the --bash option.
case ":$PATH:" in
  "/home/rbera/.vim/pack/packager/start/fzf/bin:"*) ;;
  *) PATH="/home/rbera/.vim/pack/packager/start/fzf/bin:$PATH" ;;
esac

eval "$(fzf --bash)"
