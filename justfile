# rebuild switch nixos
nixos:
	nixos-rebuild switch -j auto --use-remote-sudo --flake . 

# rebuild switch home
home:
	home-manager switch -j auto --flake .

remote-h:
	export NIX_SSHOPTS="-A"
	nixos-rebuild switch -j auto --use-remote-sudo --target-host root@pers-h --flake .#pers-h 

remote-c:
	export NIX_SSHOPTS="-A"
	nixos-rebuild switch -j auto --use-remote-sudo --fast --build-host root@pers-c --target-host root@pers-c --flake .#pers-c

# rebuild switch with more output
debug:
	nixos-rebuild switch --flake . --use-remote-sudo --show-trace --verbose

# update programs
update:
	nix flake update

uppdate input:
    nix flake lock --update-input {{input}}

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
