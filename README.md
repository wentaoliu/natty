# RTISS

<img align="right" height="150" src="https://wentaoliu.github.io/rtiss/img/rtiss-logo.svg">

[![Build Status](https://travis-ci.org/wentaoliu/rtiss.svg?branch=master)](https://travis-ci.org/wentaoliu/rtiss)
[![Dependency Status](https://gemnasium.com/wentaoliu/rtiss.svg)](https://gemnasium.com/wentaoliu/rtiss)

RTISS - _Research Team Information Sharing System_ - is a content management system (CMS) customized for research teams. Any team, large or small, have  immediate access to the handy features after a plain, out-of-the-box installation.

While is designed to have several build-in function modules for those who have little knowledge of web development, RTISS is easily extendible for those who intend to add new features.

## Features

* __Topics__ - forum

  Like a typical Internet forum, users can create a new topic which could be replied by others.

* __Wiki__ - knowledge sharing system

  The wiki invites all users to edit any page or to create new pages. Since there is no review before modifications are accepted, wiki keeps a record of changes made to wiki pages. Indeed every version of the page is stored, which means that users can view an older version of the page.

* __Schedule__ - calendar

  Users can create their own schedules and look for others' schedules by name and date.

* __Resources__ - file hosting

  Uploaded files can be classified by recursive folders.

* __News__ - sharing news

  News articles, complete with text and graphics, describe the events related to your lab.

* __Meetings__ - meeting arrangement and notice

  Remind users of the date of meetings.

* __Achievements__ - papers, patents and awards

  Achievements could be showed and archived by type.

* __Instruments__ - equipment register and booking

  Book the instrument you would use in advance.

* __Inventory__ - chemicals and supplies

  Manage quantities, locations and expiry date for chemicals and supplies.

* __Orders__ - simple finanical management

  Recorded order's details makes it easy to gather statistics and reimburse.

* __Messages__ - send messages to colleagues

  Messages can be marked as _liked_ and are visible to all users.

* __Group__ - access control

  For research teams, access control to resources may be a significant issue. Usually, you will want to assign individual users to groups and then assign permissions based on these groups. Of course, you can assign permissions to the individuals instead of groups.


* __OAuth__ - OAuth2 provider

  OAuth is commonly used as a way for users to log into third-party websites or applications using their RTISS account without exposing their password.

* __API__ - JSON interface

  This would make it drastically simpler to create third-party applications that interact with your RTISS website.

* __Internationalization__ - using RTISS in your own language

  Avaliable locales:
  > en-US (English), zh-CN (Simplified Chinese)

  Maybe your language is not avaliable or up-to-date? Please help us by adding translations to this application into your language or languages you care about.

## Dependencies

* Linux

  Mac OS and Windows are not supported.

* Ruby >=2.3.0

  The latest Ruby could be easily installed using [RVM](https://rvm.io/) or [rbenv]( https://github.com/rbenv/rbenv).

* mongoDB 2.x or 3.x

  Find the instructions for installing mongoDB in the [mongoDB Manual](https://docs.mongodb.org/manual/installation).

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
  rake RAILS_ENV=production db:seed
  ```

4. Precompile static files:

  ```
  rake RAILS_ENV=production assets:precompile
  ```

  If you deploy to a sub url, add:

  ```
  RAILS_RELATIVE_URL_ROOT='/<YOUR_SUB_URL>'
  ```

6. Use `rake secret` to set the `SECRET_KEY_BASE`  environment variable.

7. Follow the instructions in `./config/initializes/mailer.rb` to set your mailer.

8. Start: `rails server -e production`

  A more common way is to use Passenger/Puma as your web server.

  Here is a comprehensive tutorial about how to [deploy a Rails app with Passenger to production](https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/).

## License

Copyright(c) 2014-2016 [Wentao Liu](https://github.com/wentaoliu)

Released under the [MIT License](http://www.opensource.org/licenses/MIT)
