# CI

## build

Dockerfile:

```dockerfile
FROM airkro/ci:qci_worker as codingci

ARG CODING_TOKEN
ARG CODING_TEAM

RUN qci_worker cci_reg --token $CODING_TOKEN --server wss://$CODING_TEAM.coding.net

ENTRYPOINT ["qci_worker", "up"]
```
