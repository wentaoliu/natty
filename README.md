# RTISS

RTISS (Research Team Information Sharing System) is a web application based on Ruby on Rails, providing a platform for research team members to exchange information quickly and easily.

## Features

* Topics
* Wikis
* Schedule
* Resources
* News
* Meetings
* Achievements
* Instruments
* Bulletins
* Chat

## Deployment

1. Install ImageMagick:

  CentOS/Fedora:

  ```shell
  yum install ImageMagick
  ```
  Debian/Ubuntu:

  ```shell
  apt-get install imagemagick
  ```

2. Clone the repository.

3. Run `bundle install RAILS_ENV=production`.

4. Initialize database:

  ```ruby
  rake RAILS_ENV=production db:seed
  ```

5. Precompile static files:

  ```ruby
  rake RAILS_ENV=production assets:precompile
  ```

  If you deploy to a sub url, add:

  ```ruby
  RAILS_RELATIVE_URL_ROOT='/<YOUR_SUB_URL>'
  ```

6. Use `rake secret` to set the `SECRET_KEY_BASE`  environment virable.

7. Follow the instructions in `./config/initializes/mailer.rb` to set your mailer.

8. Start:

  ```shell
  rails server -e production
  ```

  or use Apache/Nginx + Passenger as your web server.

## License

Copyright(c) 2014-2015 [Wentao Liu](https://github.com/wentaoliu)

Released under the [MIT License](http://www.opensource.org/licenses/MIT)
