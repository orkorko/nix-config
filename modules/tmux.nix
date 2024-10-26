{ config, pkgs, ... }:
{
	programs.tmux = {
	    enable = true;
	    escapeTime = 0;
	    shortcut = "b";
	    keyMode = "vi";
	    extraConfig = ''
		bind -T copy-mode-vi v send-keys -X begin-selection
		bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

		set -g base-index 1

		bind -r ^ last-window
		bind -r k select-pane -U
		bind -r j select-pane -D
		bind -r h select-pane -L
		bind -r l select-pane -R

		bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
	    '';
	};
}

