# How to generate new cert?
https://scriptcrunch.com/create-ca-tls-ssl-certificates-keys/

## Generate "certificate authority" certificate
```
openssl genrsa -out ca.key 4096
```

## Generate "certificate authority" key
```
openssl req -x509 -new -nodes -key ca.key -sha512 -days 3650 -out ca.crt
```

## Validate
```
openssl x509 -in ca.crt -noout -text
```

## Add certificate to CA store
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

