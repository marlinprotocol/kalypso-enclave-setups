wget -O keygen http://public.artifacts.marlin.pro/projects/enclaves/keygen_v1.0.0_linux_amd64

wget -O oyster-keygen http://public.artifacts.marlin.pro/projects/enclaves/keygen-secp256k1_v1.0.0_linux_amd64


chmod +x keygen

chmod +x oyster-keygen

./keygen --secret ./id.sec --public ./id.pub

./oyster-keygen --secret ./secp.sec --public ./secp.pub
