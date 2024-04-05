PACK_NAME ?= 

default: clean build
	xdg-open result

build:
	nix build ".?submodules=1#${PACK_NAME}" --option substituters https://mirror.sjtu.edu.cn/nix-channels/store 

clean:
	rm -rf *.aux *.bbl *.bbl *.log *.out *.toc *.pdf
