PROJECTS := zkb_input_verifier kalypso-zkb-input-verifier-client oyster-attestation-server-secp256k1

all: $(PROJECTS)

zkb_input_verifier:
	@echo "Building zkb_input_verifier... "
	@cd dependencies/zkb_input_verifier && cargo build --release
	@cp dependencies/zkb_input_verifier/target/x86_64-unknown-linux-musl/release/zkb_input_verifier zkb_input_verifier

kalypso-zkb-input-verifier-client:
	@echo "Building kalypso-zkb-input-verifier-client... "
	@cd dependencies/kalypso-unified && cargo build --release -p ivs_client
	@cp dependencies/kalypso-unified/target/x86_64-unknown-linux-musl/release/ivs_client kalypso-zkb-input-verifier-client

oyster-attestation-server-secp256k1:
	@echo "Building oyster-attestation-utility... "
	@cd dependencies/oyster-attestation-server-secp256k1 && cargo build --release
	@cp dependencies/oyster-attestation-server-secp256k1/target/release/oyster-attestation-server-secp256k1 oyster-attestation-utility 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-unified.git
	@cd dependencies && git clone https://github.com/marlinprotocol/zkb_input_verifier.git
	@cd dependencies && git clone https://github.com/marlinprotocol/oyster-attestation-server-secp256k1

.PHONY: pull-repo
pull-repo:
	@echo "Pulling Repo"
	@cd dependencies/zkb_input_verifier && git pull
	@cd dependencies/kalypso-unified && git pull
	@cd dependencies/oyster-attestation-server-secp256k1 && git pull

.PHONY: clean
clean:
	@rm -rf dependencies
	@rm -f oyster-attestation-utility kalypso-zkb-input-verifier-client zkb_input_verifier
