PROJECTS := kalypso-generator generator-client oyster-attestation-utility

all: $(PROJECTS)

kalypso-generator:
	@echo "Building kalypso-generator... "
	@cd dependencies/kalypso-generator && cargo build --release
	@cp dependencies/kalypso-generator/target/x86_64-unknown-linux-musl/release/kalypso-generator kalypso-generator

generator-client:
	@echo "Building generator-client... "
	@cd dependencies/kalypso-unified && cargo build --release -p generator_client
	@cp dependencies/generator-client/target/x86_64-unknown-linux-musl/release/generator-client generator-client

oyster-attestation-utility:
	@echo "Building oyster-attestation-utility... "
	@cd dependencies/oyster-attestation-server-secp256k1 && cargo build --release
	@cp dependencies/oyster-attestation-server-secp256k1/target/release/oyster-attestation-server-secp256k1 oyster-attestation-utility 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	# @cd dependencies && git clone https://github.com/marlinprotocol/kalypso-generator.git
	@cd dependencies && git clone https://github.com/marlinprotocol/oyster-attestation-server-secp256k1
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-unified.git

.PHONY: pull-repo
pull-repo:   
	@echo "Pulling Repo"
	@cd dependencies/kalypso-generator && git pull
	@cd dependencies/kalypso-unified && git pull
	@cd dependencies/oyster-attestation-server-secp256k1 && git pull

.PHONY: clean
clean:
	@rm -f oyster-attestation-utility generator-client kalypso-generator
	@rm -rf dependencies
