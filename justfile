# rebuild switch all
all: nixos home

# rebuild switch nixos
nixos:
	nixos-rebuild switch --flake . --use-remote-sudo

# rebuild switch home
home:
	home-manager switch --flake .

# rebuild switch with more output
debug:
	nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

# update programs
update:
	nix flake update

# display history
history:
	nix profile history --profile /nix/var/nix/profiles/system

# collect garbage
gc:
	# remove all generations older than 7 days
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
	home-manager expire-generations '-7 days'

	# garbage collect all unused nix store entries
	sudo nix store gc --debug
