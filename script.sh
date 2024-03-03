#!/bin/sh
kubectl get secret $1 -n devtroncd -o jsonpath='{.data.tls\.crt}' | base64 -d | awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ".pem"}'
kubectl get secret $1 -n devtroncd -o jsonpath='{.data.tls\.key}' | base64 -d  >  PrivateKey.pem
kubectl get secret $1 -n devtroncd -o jsonpath='{.data.tls\.crt}' | base64 -d > certchain.pem

aws acm import-certificate --certificate fileb://cert.pem \
      --certificate-chain fileb://certchain.pem \
      --private-key fileb://PrivateKey.pem \
      --certificate-arn $2
