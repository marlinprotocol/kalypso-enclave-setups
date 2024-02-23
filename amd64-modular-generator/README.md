# Kalypso generator

Build and run the EIF with `./build.sh`

EC2 Instance public IP : `43.205.85.160`

## Steps to start the generator

1. Update the ECIES key with the help of KalypsoSDK
    ```
    yarn test ./test/generatorOperations/update_ecies_key.ts
    ```
2. Generate the config setup by making an HTTP call to the generator client:
    ```
    curl --location --request POST 'http://43.205.85.160:5000/api/generatorConfigSetup' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "generator_config": [
        {
          "address": "0xbCa21b37A139723F5546b5951f00B42e8E9a7D85",
          "data": "Some data",
          "supported_markets": [
            "0"
          ]
        }
      ],
    
      "runtime_config": {
        "ws_url": "wss://arb-sepolia.g.alchemy.com/v2/************",
        "http_url": "https://arb-sepolia.g.alchemy.com/v2/***********",
        "private_key": "***********************",
        "start_block": 16440453,
        "chain_id": 421614,
        "payment_token": "0x01d84D33CC8636F83d2bb771e184cE57d8356863",
        "staking_token": "0xdb69299dDE4A00c99b885D9f8748B2AeD1Fe4Ed4",
        "attestation_verifier": "0x3D116255C2b06D7672a9512958d9a3FFD7Aea50c",
        "entity_registry": "0xFa1004E359fd8Cb76a7D5F32b954eF5020Ea033c",
        "proof_market_place": "0x27FDcb086Cdb0bCFa40638376CD3CbF5B8c69197",
        "generator_registry": "0x008d842cA209690D9Da5431a94e193A7B93aC105",
        "ivs_url":"http://43.205.177.43:3030/checkInput",
        "markets":{
            "0":"6000",
            "1":"7000"
        }
      }
    }'
    ```
3. Start the zkbob-generator by invoking the following API call
    ```
    curl --location --request POST 'http://43.205.85.160:5000/api/startGenerator' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "generator_name":"zkbob-generator"
    }'
    ```
4. Start the kalypso-listener by invoking the following API call
    ```
    curl --location --request POST 'http://43.205.85.160:5000/api/startGenerator' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "generator_name":"listener"
    }'
    ```
      


