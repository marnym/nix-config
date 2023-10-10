deploy:
	nixos-rebuild switch --flake . --use-remote-sudo

deploy-home:
	home-manager switch --flake .

debug:
	nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

update:
	nix flake update

history:
	nix profile history --profile /nix/var/nix/profiles/system

gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
	home-manager expire-generations '-7 days'

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
