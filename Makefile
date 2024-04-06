# Maybe you will not only use one packages.default
PACK_NAME ?= main
SUBSTITUTERS := --option substituters https://mirror.sjtu.edu.cn/nix-channels/store
DEFAULT_PDF_READER := xdg-open

default: clean build
	${DEFAULT_PDF_READER} ${PACK_NAME}.pdf

build: # Build up your documents
ifeq ($(IN_NIX_SHELL),impure)
	latexmk -xelatex ${PACK_NAME}.tex
else
	nix develop ".?submodules=1#"  ${SUBSTITUTERS} --command latexmk -xelatex ${PACK_NAME}.tex
endif

dev: # Open a develop shell with tools
ifeq ($(IN_NIX_SHELL),impure)
	@echo "You're already inside."
else
	nix develop ".?submodules=1#" ${SUBSTITUTERS} 
endif

clean:
ifeq ($(IN_NIX_SHELL),impure)
	latexmk -c
else
	rm -rf *.aux *.bbl *.bbl *.log *.out *.toc *.pdf *.gz *.zip *.aux *.log *.bbl *.blg *.toc *.out *.fdb_latexmk *.fls *.xdv
endif

#--------------------------------------------------
# Nix Instruction
#--------------------------------------------------
.PHONY: install-nix uninstall-nix monitor

# Install Single-User Nix into your system
install-nix:
	if ! command -v nix >/dev/null 2>&1; then \
		echo "Installing Nix...";\
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install;\
	else \
		echo "You have already installed Nix.";\
	fi
	# ref:
	# https://nixos.org/download.html
	# https://www.reddit.com/r/NixOS/comments/wyw7pa/multi_user_vs_single_user_installation/
	# sh <(curl -L https://nixos.org/nix/install) --no-daemon;\

# Uninstall Single-User Nix 
uninstall-nix:
	@echo "will removing nix single user installing in 5 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 4 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 3 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 2 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 1 seconds... <using Ctrl + C to stop it>";
	/nix/nix-installer uninstall
	# ref:
	# https://nixos.org/download.html#nix-install-linux
	# https://github.com/NixOS/nix/pull/8334

monitor:
	 inotifywait --event=create --event=modify --event=moved_to --exclude='/(dev|nix|proc|run|sys|tmp|var)/.*' --monitor --no-dereference --quiet --recursive /
	# ref:
	# https://github.com/NixOS/nix/pull/8334

#-------------------------------------------------- 
#  OTHERS
#-------------------------------------------------- 
git-log:
	git log --graph --abbrev-commit --decorate --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
