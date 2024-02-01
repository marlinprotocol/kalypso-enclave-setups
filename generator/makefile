PROJECTS := kalypso-generator generator-client oyster-attestation-utility

all: $(PROJECTS)

kalypso-generator:
	@echo "Building kalypso-generator... "
	@cd dependencies/kalypso-generator && cargo build

generator-client:
	@echo "Building generator-client... "
	@cd dependencies/generator-client && cargo build
	@cp dependencies/generator-client/target/x86_64-unknown-linux-musl/debug/generator-client generator-client

oyster-attestation-utility:
	@echo "Building oyster-attestation-utility... "
	@cd dependencies/oyster-attestation-server-secp256k1 && cargo build
	@cp dependencies/oyster-attestation-server-secp256k1/target/debug/oyster-attestation-server-secp256k1 oyster-attestation-utility 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-generator.git
	@cd dependencies && git clone https://github.com/marlinprotocol/generator-client.git
	@cd dependencies && git clone https://github.com/marlinprotocol/oyster-attestation-server-secp256k1

.PHONY: pull-repo
pull-repo:
	@echo "Pulling Repo"
	@cd dependencies/kalypso-generator && git pull
	@cd dependencies/generator-client && git pull
	@cd dependencies/oyster-attestation-server-secp256k1 && git pull

.PHONY: clean
	@rm -rf dependencies