all:
	$(error Run make machine or make user)

machine:
	nixos-rebuild switch --use-remote-sudo --flake ./nixos#$(filter-out $@,$(MAKECMDGOALS))

vm:
	nixos-rebuild build-vm --flake ./nixos#vm

user:
	home-manager switch --flake ./home/#doos

watch-user:
	watchexec -w home -e nix "make user"

watch-machine:
	watchexec -w nixos -e nix "make machine"

gc:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 10d
	home-manager expire-generations "-10 days"