PROJECTS := kalypso-matching-engine kalypso-matching-engine-client oyster-attestation-utility

all: $(PROJECTS)

kalypso-matching-engine:
	@echo "Building kalypso-matching-engine... "
	@cd dependencies/kalypso-matching-engine && cargo build --release
	@cp dependencies/kalypso-matching-engine/target/x86_64-unknown-linux-musl/release/matching-engine kalypso-matching-engine

kalypso-matching-engine-client:
	@echo "Building kalypso-matching-engine-client... "
	@cd dependencies/kalypso-matching-engine-client && cargo build --release
	@cp dependencies/kalypso-matching-engine-client/target/x86_64-unknown-linux-musl/release/kalypso-matching-engine-client kalypso-matching-engine-client

oyster-attestation-utility:
	@echo "Building oyster-attestation-utility... "
	@cd dependencies/oyster-attestation-server-secp256k1 && cargo build --release
	@cp dependencies/oyster-attestation-server-secp256k1/target/release/oyster-attestation-server-secp256k1 oyster-attestation-utility 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-matching-engine-client.git
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-matching-engine.git
	@cd dependencies && git clone https://github.com/marlinprotocol/oyster-attestation-server-secp256k1

.PHONY: pull-repo
pull-repo:
	@echo "Pulling Repo"
	@cd dependencies/kalypso-matching-engine && git pull
	@cd dependencies/kalypso-matching-engine-client && git pull
	@cd dependencies/oyster-attestation-server-secp256k1 && git pull

.PHONY: clean
clean:
	@rm -rf dependencies
	@rm -f kalypso-matching-engine kalypso-matching-engine-client oyster-attestation-utility
