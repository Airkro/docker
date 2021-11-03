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

## Usage

```sh
docker pull airkro/node-lts
```

## Compare Size

### Size of airkro/node-lts:tag

|                      Size | Tag        | Features                                                                          |
| ------------------------: | ---------- | :-------------------------------------------------------------------------------- |
|         ![latest][latest] | latest     | git / zip / ssh                                                                   |
|     ![imagemin][imagemin] | imagemin   | git / zip / ssh / imagemin                                                        |
|       ![python3][python3] | python3    | git / zip / ssh / imagemin / python3                                              |
| ![playwright][playwright] | playwright | git / zip / ssh / imagemin / python3 / playwright                                 |
|           ![fonts][fonts] | fonts      | git / zip / ssh / imagemin / python3 / playwright / fonts-roboto / fonts-noto-cjk |

[latest]: https://flat.badgen.net/docker/size/airkro/node-lts/latest?label=
[imagemin]: https://flat.badgen.net/docker/size/airkro/node-lts/imagemin?label=
[python3]: https://flat.badgen.net/docker/size/airkro/node-lts/python3?label=
[playwright]: https://flat.badgen.net/docker/size/airkro/node-lts/playwright?label=
[fonts]: https://flat.badgen.net/docker/size/airkro/node-lts/fonts?label=

<style>
table img {
  vertical-align: middle;
}
</style>
