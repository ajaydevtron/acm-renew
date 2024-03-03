FROM quay.io/devtron/k8s-utils:acm-renew-v2
COPY script.sh script.sh
RUN chmod +x script.sh
