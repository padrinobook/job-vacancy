![PadrinoBook - The Guide To Master The Elegant Ruby Web Framework](https://raw.githubusercontent.com/wikimatze/padrinobook/master/images/logo.png "PadrinoBook - The Guide To Master The Elegant Ruby Web Framework")

[![CircleCI](https://circleci.com/gh/padrinobook/job-vacancy.svg?style=svg)](https://app.circleci.com/pipelines/github/padrinobook/job-vacancy)
![Build Status](https://travis-ci.org/padrinobook/job-vacancy.svg?branch=master)
[![](https://img.shields.io/gitter/room/padrinobook/padrinobook.svg)](https://gitter.im/padrinobook/padrinobook)
[![](https://img.shields.io/twitter/follow/padrinobook.svg?label=Follow&style=social)](https://twitter.com/padrinobook)
![Coverage Status](https://coveralls.io/repos/github/padrinobook/job-vacancy/badge.svg?branch=master)


This is the application written for my [PadrinoBook](https://padrinobook.com). There are a lots of commits in there - so
feel free to sniff around.


# Build

Get the code


```sh
git clone https://github.com/padrinobook/job-vacancy
```


Install dependencies:


```sh
cd job-vacancy && bundle
```


Create all databases:


```sh
bundle exec rake ar:create:all
```


Run migrations:


```sh
bundle exec padrino rake ar:migrate -e production && bundle exec padrino rake ar:migrate -e test
```


Run the tests:


```sh
bundle exec rspec
```


Start the app:


```sh
bundle exec padrino s
```


# Specs

Follow the style written under: <http://www.betterspecs.org/#describe>

# License

This software is licensed under the [MIT](http://en.wikipedia.org/wiki/MIT_License) license.

© Matthias Günther <matthias@padrinobook.com>.

