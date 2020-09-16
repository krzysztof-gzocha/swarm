#!/usr/bin/env sh
openssl genrsa -out ca.key 4096 && \
openssl req -x509 -new -nodes -key ca.key -sha512 -days 3650 -out ca.crt && \
openssl x509 -in ca.crt -noout -text && \
openssl genrsa -out server.key 2048 && \
openssl req -new -key server.key -out server.csr -config csr.conf && \
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
-CAcreateserial -out server.crt -days 10000 \
-extfile csr.conf && \
echo "CA and server certificates are ready. You can import ca.crt into your browser to trust it" && \
echo "If you need more domain you can create new certificates for new domains, but remember to include them in config/traefik.yml and config/traefik/tls.yml"
