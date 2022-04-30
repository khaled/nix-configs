all:
	$(error Run make machine or make user)

machine:
	nixos-rebuild switch --use-remote-sudo --flake .#$(filter-out $@,$(MAKECMDGOALS))

vm:
	nixos-rebuild build-vm --flake .#vm

watch-machine:
	watchexec -e nix "time nixos-rebuild build --use-remote-sudo --flake .#"

gc:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 10d
	home-manager expire-generations "-10 days"