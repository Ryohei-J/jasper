#!/bin/bash

# certbotで証明書を更新
certbot certonly --authenticator dns-oci -d bscrape.com --agree-tos --force-renewal

# 更新した証明書をOCIにインポート
certificate_id="ocid1.certificate.oc1.ap-tokyo-1.amaaaaaavstm55ya55heqjmiyk7ngkixnmscxmewjrs3wichhf2xcwocqhpq"
certificate_pem=$(cat /etc/letsencrypt/live/bscrape.com/cert.pem)
cert_chain_pem=$(cat /etc/letsencrypt/live/bscrape.com/chain.pem)
private_key_pem=$(cat /etc/letsencrypt/live/bscrape.com/privkey.pem)

oci certs-mgmt certificate update-certificate-by-importing-config-details \
    --certificate-id "$certificate_id"\
    --certificate-pem "$certificate_pem"\
    --cert-chain-pem "$cert_chain_pem"\
    --private-key-pem "$private_key_pem"
