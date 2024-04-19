# airkro/node-lts

Docker image for node.js develop.

[![docker page][docker-badge]][docker-link]
[![github repo][github-badge]][github-link]

[docker-badge]: https://img.shields.io/docker/stars/airkro/node-lts?logo=docker&style=flat-square
[docker-link]: https://hub.docker.com/r/airkro/node-lts
[github-badge]: https://img.shields.io/github/license/airkro/docker.svg?logo=github&style=flat-square&color=blue
[github-link]: https://github.com/airkro/docker

## Usage

```sh
docker pull airkro/node-lts
```

## Compare Size

### Size of node:tag

|              Size | Tag             |
| ----------------: | --------------- |
| ![alpine][alpine] | node:lts-alpine |
|     ![slim][slim] | node:lts-slim   |
|       ![lts][lts] | node:lts        |

[alpine]: https://img.shields.io/docker/image-size/_/node/lts-alpine?label=&style=flat-square
[slim]: https://img.shields.io/docker/image-size/_/node/lts-slim?label=&style=flat-square
[lts]: https://img.shields.io/docker/image-size/_/node/lts?label=&style=flat-square

### Size of airkro/node-lts:tag

|                          Size | Tag          | Features                                                |
| ----------------------------: | :----------- | :------------------------------------------------------ |
|             ![latest][latest] | latest       | git / zip / docker-cli / corepack                       |
|                   ![ssh][ssh] | ssh          | tag:latest / ssh                                        |
|             ![sentry][sentry] | sentry       | tag:latest / npm:@sentry/cli                            |
|           ![python3][python3] | python3      | tag:latest / python3 / pip                              |
|       ![cocoapods][cocoapods] | cocoapods    | tag:latest / ruby / cocoapods                           |
| ![mp-wechat-ci][mp-wechat-ci] | mp-wechat-ci | tag:latest / npm:miniprogram-ci                         |
| ![mp-alipay-ci][mp-alipay-ci] | mp-alipay-ci | tag:python3 / npm:minidev                               |
|               ![mp-ci][mp-ci] | mp-ci        | tag:python3 / npm:miniprogram-ci / npm:minidev          |
|           ![browser][browser] | browser      | git / zip / ssh / corepack / playwright / Noto Sans ... |

[latest]: https://flat.badgen.net/docker/size/airkro/node-lts/latest?label=
[ssh]: https://flat.badgen.net/docker/size/airkro/node-lts/ssh?label=
[sentry]: https://flat.badgen.net/docker/size/airkro/node-lts/sentry?label=
[python3]: https://flat.badgen.net/docker/size/airkro/node-lts/python3?label=
[cocoapods]: https://flat.badgen.net/docker/size/airkro/node-lts/cocoapods?label=
[browser]: https://flat.badgen.net/docker/size/airkro/node-lts/browser?label=
[mp-wechat-ci]: https://flat.badgen.net/docker/size/airkro/node-lts/mp-wechat-ci?label=
[mp-alipay-ci]: https://flat.badgen.net/docker/size/airkro/node-lts/mp-alipay-ci?label=
[mp-ci]: https://flat.badgen.net/docker/size/airkro/node-lts/mp-ci?label=
