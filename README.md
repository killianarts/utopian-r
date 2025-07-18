# Utopian-R

[![Quicklisp dist](http://quickdocs.org/badge/utopian-r.svg)](http://quickdocs.org/utopian/)

> The caveman in offering the first garland to his maiden thereby transcended the brute. He became a utopian-r in thus rising above the crude necessities of nature. He entered the realm of art when he perceived the subtle use of the useless.
> -- Okakura Tenshin, "The Book of Tea"

3 steps to write a better web application:

1. Choose the right language.
2. Choose the right web framework.
3. Write less.

Utopian-R is a web application framework that encourages rapid web development.

## Requirements

* [Roswell](https://github.com/roswell/roswell)
* [Qlot](https://github.com/fukamachi/qlot)
* An RDBMS you like one of SQLite3, MySQL or PostgreSQL.

## Getting started

### Installation

```
$ ros install fukamachi/utopian-r
$ ros install fukamachi/lsx
$ ros install fukamachi/qlot
```

Ensure `~/.roswell/bin` is in your shell `$PATH`.

### Creating a new project

To generate the project skeleton, open a terminal and execute this command:

```
$ utopian-r new blog
```

### Installing dependencies

```
$ cd blog/
$ qlot install
```

### Database Settings

This section is needed only when using MySQL or PostgreSQL.

#### Creating a database user

##### PostgreSQL

```
$ createuser -d blog
```

##### MySQL

```
$ mysql -u root
mysql> CREATE USER blog@localhost IDENTIFIED BY '';
mysql> GRANT ALL ON *.* TO blog@localhost;
```

#### Creating a database

```
$ .qlot/bin/utopian-r db create
```

### Starting a development server

```
$ .qlot/bin/utopian-r server
Hunchentoot server is going to start.
Listening on localhost:5000.
```

## DB Migration

Add Mito table classes under `models/` directory and run the following commands:

```
$ .qlot/bin/utopian-r generate migration
$ .qlot/bin/utopian-r db migrate
```

## Examples

See [examples/](https://github.com/fukamachi/utopian-r/tree/next/examples) directory.

## See Also

- [Clack](https://github.com/fukamachi/clack) / [Lack](https://github.com/fukamachi/lack)
- [MyWay](https://github.com/fukamachi/myway): Sinatra-compatible router.
- [Mito](https://github.com/fukamachi/mito): An O/R Mapper with schema versioning.
- [LSX](https://github.com/fukamachi/lsx): Embeddable HTML Templating engine.

## Author

Eitaro Fukamachi (e.arrows@gmail.com)

## Copyright

Copyright (c) 2016-2018 Eitaro Fukamachi

## License

Licensed under the LLGPL License.
