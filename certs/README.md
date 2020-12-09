# How to generate new cert?
https://scriptcrunch.com/create-ca-tls-ssl-certificates-keys/

# Simplest installation
Install mkcert with this link: https://github.com/FiloSottile/mkcert#installation
```
~/mkcert-v1.4.3-linux-amd64 --install -ecdsa -cert-file server.crt -key-file server.key "*.house.swarm"
```

## CA

### Generate "certificate authority" certificate
```
openssl genrsa -out ca.key 4096
```

### Generate "certificate authority" key
You might want to update `-days` flag. Use `house.swarm` as Common Name.
Generate separate certificate for other domains if required.
```
openssl req -x509 -new -nodes -key ca.key -sha512 -days 3650 -out ca.crt
```

### Validate
```
openssl x509 -in ca.crt -noout -text
```

## Server cert signed with CA
### Generate server key
```
openssl genrsa -out server.key 2048
```

### Use csf.conf to generate signed CSR
```
openssl req -new -key server.key -out server.csr -config csr.conf
```

### Sign server key with CA
```
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key \
-CAcreateserial -out server.crt -days 10000 \
-extfile csr.conf
```

### Add certificate to your browser trusted store in settings

### Add certificate to CA store if required
#### Ubuntu
```
sudo cp ca.crt /usr/local/share/ca-certificates/swarm.crt
sudo update-ca-certificates
```

#### Others
```
sudo cp /tmp/ca.crt /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust
```

# ... or
Just call the script to trigger all of that for you:
```
./certs/generate.sh
```
