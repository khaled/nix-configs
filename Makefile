machine:
	nixos-rebuild switch --use-remote-sudo --flake .#

vm:
	nixos-rebuild build-vm --flake .#vm

watch:
	watchexec -e nix "make"

gc:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 10d
	home-manager expire-generations "-10 days"