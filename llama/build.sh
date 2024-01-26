rm ollama
rm nitro-enclave.eif
wget -O ollama https://ollama.ai/download/ollama-linux-amd64

# #!/bin/sh
# nitro-cli terminate-enclave --all
# FILE=nitro-enclave.eif
# if [ -f "$FILE" ]; then
#     rm $FILE
# fi
# docker rmi -f $(docker images -a -q)
# docker build --no-cache ./ -t nitroimg
# nitro-cli build-enclave --docker-uri nitroimg:latest --output-file nitro-enclave.eif
# nitro-cli run-enclave --cpu-count 4 --memory 5000 --eif-path nitro-enclave.eif --enclave-cid 88


#!/bin/sh
nitro-cli terminate-enclave --all
FILE=nitro-enclave.eif
if [ -f "$FILE" ]; then
    rm $FILE
fi
docker rmi -f $(docker images -a -q)
docker build --no-cache ./ -t nitroimg
nitro-cli build-enclave --docker-uri nitroimg:latest --output-file nitro-enclave.eif
nitro-cli run-enclave --cpu-count 4 --memory 8000 --eif-path nitro-enclave.eif --enclave-cid 88 --debug-mode --attach-console
# nitro-cli console --enclave-id $(nitro-cli describe-enclaves | jq -r ".[0].EnclaveID")





