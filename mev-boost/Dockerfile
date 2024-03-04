# base image
FROM alpine:3.17

# install dependency tools
RUN apk add --no-cache net-tools iptables iproute2 wget

RUN apk update && apk add redis postgresql

# Additional setup for Redis and PostgreSQL can go here
# For example, configuring Redis to run in the background:
RUN sed -i 's/^# \(bind .*\)$/\1/' /etc/redis.conf
RUN sed -i 's/^# \(protected-mode no\)$/\1/' /etc/redis.conf
RUN echo 'daemonize yes' >> /etc/redis.conf

# Initialize PostgreSQL database
# Note: This is a very basic setup. For production, you would need to secure and configure the databases according to your needs.
RUN mkdir /run/postgresql
RUN chown postgres:postgres /run/postgresql
USER postgres
RUN initdb -D /var/lib/postgresql/data

# working directory
WORKDIR /app

# supervisord to manage programs
RUN wget -O supervisord http://public.artifacts.marlin.pro/projects/enclaves/supervisord_master_linux_amd64
RUN chmod +x supervisord

# transparent proxy component inside the enclave to enable outgoing connections
RUN wget -O ip-to-vsock-transparent http://public.artifacts.marlin.pro/projects/enclaves/ip-to-vsock-transparent_v1.0.0_linux_amd64
RUN chmod +x ip-to-vsock-transparent

# key generator to generate static keys
RUN wget -O keygen http://public.artifacts.marlin.pro/projects/enclaves/keygen_v1.0.0_linux_amd64
RUN chmod +x keygen

# attestation server inside the enclave that generates attestations
RUN wget -O attestation-server http://public.artifacts.marlin.pro/projects/enclaves/attestation-server_v1.0.0_linux_amd64
RUN chmod +x attestation-server

# proxy to expose attestation server outside the enclave
RUN wget -O vsock-to-ip http://public.artifacts.marlin.pro/projects/enclaves/vsock-to-ip_v1.0.0_linux_amd64
RUN chmod +x vsock-to-ip

# dnsproxy to provide DNS services inside the enclave
RUN wget -O dnsproxy http://public.artifacts.marlin.pro/projects/enclaves/dnsproxy_v0.46.5_linux_amd64
RUN chmod +x dnsproxy

RUN wget -O oyster-keygen http://public.artifacts.marlin.pro/projects/enclaves/keygen-secp256k1_v1.0.0_linux_amd64
RUN chmod +x oyster-keygen

# supervisord config
COPY supervisord.conf /etc/supervisord.conf

# setup.sh script that will act as entrypoint
COPY setup.sh ./
RUN chmod +x setup.sh

#attestation utility
RUN wget -O oyster-attestation-utility http://public.artifacts.marlin.pro/projects/enclaves/attestation-server-secp256k1_v1.0.0_linux_amd64
RUN chmod +x oyster-attestation-utility

COPY mev-boost-relay ./
RUN chmod +x mev-boost-relay

# entry point
ENTRYPOINT [ "/app/setup.sh" ]