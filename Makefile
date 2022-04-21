all:
	$(error Run make machine or make user)

machine:
	sudo nixos-rebuild switch --flake ./nixos

user:
	home-manager switch --flake ./home/#doos

watch-user:
	watchexec -w home -e nix "make user"

watch-machine:
	watchexec -w nixos -e nix "make machine"

gc:
	sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2	
	sudo nixos-rebuild boot
	home-manager expire-generations "-30 days"