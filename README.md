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

|              Size | Tag        |
| ----------------: | ---------- |
| ![alpine][alpine] | lts-alpine |
|     ![slim][slim] | lts-slim   |
|       ![lts][lts] | lts        |

[alpine]: https://img.shields.io/docker/image-size/_/node/lts-alpine?label=&style=flat-square
[slim]: https://img.shields.io/docker/image-size/_/node/lts-slim?label=&style=flat-square
[lts]: https://img.shields.io/docker/image-size/_/node/lts?label=&style=flat-square

### Size of airkro/node-lts:tag

|                      Size | Tag        | Features                                                     |
| ------------------------: | :--------- | :----------------------------------------------------------- |
|         ![latest][latest] | latest     | git / zip / ssh                                              |
|     ![imagemin][imagemin] | imagemin   | git / zip / ssh / imagemin                                   |
|       ![python3][python3] | python3    | git / zip / ssh / python3                                    |
| ![playwright][playwright] | playwright | git / zip / ssh / playwright                                 |
|       ![browser][browser] | browser    | git / zip / ssh / playwright / fonts-roboto / fonts-noto-cjk |

[latest]: https://flat.badgen.net/docker/size/airkro/node-lts/latest?label=
[imagemin]: https://flat.badgen.net/docker/size/airkro/node-lts/imagemin?label=
[python3]: https://flat.badgen.net/docker/size/airkro/node-lts/python3?label=
[playwright]: https://flat.badgen.net/docker/size/airkro/node-lts/playwright?label=
[browser]: https://flat.badgen.net/docker/size/airkro/node-lts/browser?label=
