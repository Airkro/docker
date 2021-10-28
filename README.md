# airkro/node-lts

Docker image for node.js develop.

[![docker page][docker-badge]][docker-link]
[![github repo][github-badge]][github-link]

[docker-badge]: https://img.shields.io/docker/stars/airkro/node-lts?logo=docker&style=flat-square
[docker-link]: https://hub.docker.com/r/airkro/node-lts
[github-badge]: https://img.shields.io/github/license/airkro/docker.svg?logo=github&style=flat-square&color=blue
[github-link]: https://github.com/airkro/docker

## About

Some `npm` dependencies like `imagemin-*` need some packages, Use this image or `airkro/node-lts` can save the day.

`git / zip / ssh` was installed by default.

## Usage

```sh
docker pull airkro/node-lts
```

## Compare Size

|   Size | Image           | Tag        | Features                                                            |
| -----: | --------------- | ---------- | ------------------------------------------------------------------- |
|  39 MB | node            | lts-alpine |                                                                     |
|  58 MB | node            | lts-slim   |                                                                     |
| 346 MB | node            | lts        |                                                                     |
|  50 MB | airkro/node-lts | latest     |                                                                     |
|  84 MB | airkro/node-lts | imagemin   | imagemin                                                            |
|  97 MB | airkro/node-lts | python3    | imagemin / python3                                                  |
| 724 MB | airkro/node-lts | playwright | imagemin / python3 / playwright                                     |
| 800 MB | airkro/node-lts | fonts      | imagemin / python3 / playwright <br/> fonts-roboto / fonts-noto-cjk |
