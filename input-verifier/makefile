PROJECTS := zkb_input_verifier kalypso-zkb-input-verifier-client oyster-attestation-server-secp256k1

all: $(PROJECTS)

zkb_input_verifier:
	@echo "Building zkb_input_verifier... "
	@cd dependencies/zkb_input_verifier && cargo build

kalypso-zkb-input-verifier-client:
	@echo "Building kalypso-zkb-input-verifier-client... "
	@cd dependencies/kalypso-zkb-input-verifier-client && cargo build
	# @cp dependencies/kalypso-matching-engine-client/target/x86_64-unknown-linux-musl/debug/kalypso-matching-engine-client kalypso-matching-engine-client

oyster-attestation-server-secp256k1:
	@echo "Building oyster-attestation-utility... "
	@cd dependencies/oyster-attestation-server-secp256k1 && cargo build
	# @cp dependencies/oyster-attestation-server-secp256k1/target/debug/oyster-attestation-server-secp256k1 oyster-attestation-utility 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-generator.git
	@cd dependencies && git clone https://github.com/marlinprotocol/zkb_input_verifier.git
	@cd dependencies && git clone https://github.com/marlinprotocol/oyster-attestation-server-secp256k1

.PHONY: pull-repo
pull-repo:
	@echo "Pulling Repo"
	@cd dependencies/zkb_input_verifier && git pull
	@cd dependencies/kalypso-zkb-input-verifier-client && git pull
	@cd dependencies/oyster-attestation-server-secp256k1 && git pull

.PHONY: clean
	@rm -rf dependencies