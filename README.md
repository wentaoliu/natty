# Natty

<img align="right" height="150" src="https://wentaoliu.github.io/natty/img/logo.svg">

[![Build Status](https://travis-ci.org/wentaoliu/natty.svg?branch=master)](https://travis-ci.org/wentaoliu/natty)

Natty is a knowledge management system for research teams.

## Features

* __Topics__ - Forum

* __Wiki__ - Simplified 'wikipedia'

* __Schedule__ - Calendar

* __Resources__ - File hosting

* __Instruments__ - Equipment register and booking

* __Inventory__ - Chemicals and supplies

* __Messages__ - Sending messages to colleagues

* __Group__ - Access control

* __API__

* __Internationalization__

  Currently avaliable locales:
  > en-US (English), zh-CN (Simplified Chinese)

## Dependencies

* Linux

  Support of Windows is not guaranteed.

* Ruby >=2.3.0

  The latest Ruby could be easily installed using [RVM](https://rvm.io/) or [rbenv]( https://github.com/rbenv/rbenv).

* PostgreSQL >= 9.4

* Bundler

  `gem install bundler`

* Git

  CentOS/Fedora: `yum install git`

  Debian/Ubuntu: `apt-get install git`

* ImageMagick

  CentOS/Fedora: `yum install ImageMagick`

  Debian/Ubuntu: `apt-get install imagemagick`

* Apache/Nginx

  CentOS/Fedora: `yum install httpd` / `yum install nginx`

  Debian/Ubuntu: `apt-get install apache2` / `apt-get install nginx`

## Deployment

1. Clone the repository.

2. Install required gems: `bundle install`.

3. Initialize the database:

  ```
  rake RAILS_ENV=production db:setup
  ```

4. Precompile static files:

  ```
  rake RAILS_ENV=production assets:precompile
  ```

  If you deploy to a sub url, add:

  ```
  RAILS_RELATIVE_URL_ROOT='/<YOUR_SUB_URL>'
  ```

6. Use `rails credentials:edit` to set application credentials.

7. Follow the instructions in `./config/initializes/mailer.rb` to set your mailer.

8. Start: `rails server -e production`

  A more common way is to use Passenger/Puma as your web server.

  Here is a comprehensive tutorial about how to [deploy a Rails app with Passenger to production](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/).

## License

Copyright(c) 2015-2018 [Wentao Liu](https://github.com/wentaoliu)

Released under the [MIT License](http://www.opensource.org/licenses/MIT)
