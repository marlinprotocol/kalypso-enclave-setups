PROJECTS := kalypso-listener generator-client zkbob-generator
all: $(PROJECTS)

kalypso-listener:
	@echo "Building kalypso-listener... "
	@cd dependencies/kalypso-unified && cargo build --release -p listener
	@cp dependencies/kalypso-listener/target/x86_64-unknown-linux-musl/release/listener kalypso-listener

generator-client:
	@echo "Building generator-client... "
	@cd dependencies/kalypso-unified && cargo build --release -p generator_client
	@cp dependencies/generator-client/target/x86_64-unknown-linux-musl/release/generator-client generator-client

zkbob-generator:
	@echo "Building zkbob-generator... "
	@cd dependencies/zkbob-generator && cargo build --release
	@cp dependencies/zkbob-generator/target/release/zkbob-generator zkbob-generator 

.PHONY: clone-repos
clone-repos:
	@echo "Cloning Repo"
	@mkdir -p dependencies 
	@cd dependencies && git clone https://github.com/marlinprotocol/kalypso-unified.git
	@cd dependencies && git clone https://github.com/marlinprotocol/zkbob-generator.git

.PHONY: pull-repo
pull-repo:   
	@echo "Pulling Repo"
	@cd dependencies/kalypso-unified && git pull
	@cd dependencies/zkbob-generator && git pull

.PHONY: clean
clean:
	@rm -f zkbob-generator generator-client kalypso-listener
	@rm -rf dependencies
