# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
"# Secondcry_prod" 
Installation

Requirements

Before you get started, the following needs to be installed:

Ruby. Version 2.1.8 is currently used and we don't guarantee everything works with other versions. If you need multiple versions of Ruby, RVM is recommended.
RubyGems
Bundler: gem install bundler
Git
A database. Only MySQL has been tested, so we give no guarantees that other databases (e.g. PostgreSQL) work. You can install MySQL Community Server two ways:
If you are on a Mac, use homebrew: brew install mysql (highly recommended). Also consider installing the MySQL Preference Pane to control MySQL startup and shutdown. It is packaged with the MySQL downloadable installer, but can be easily installed as a stand-alone.
Download a MySQL installer from here
Sphinx. Version 2.1.4 has been used successfully, but newer versions should work as well. Make sure to enable MySQL support. If you're using OS X and have Homebrew installed, install it with brew install sphinx --with-mysql
Imagemagick. If you're using OS X and have Homebrew installed, install it with brew install imagemagick
Setting up the development environment

Get the code. Cloning this git repo is probably easiest way:
git clone git://github.com/sharetribe/sharetribe.git
Navigate to the Sharetribe project root directory.
cd sharetribe
Install the required gems by running the following command in the project root directory:
bundle install
Create a database.yml file by copying the example database configuration:
cp config/database.example.yml config/database.yml
Add your database configuration details to config/database.yml. You will probably only need to fill in the password for the database(s).

Create a config.yml file by copying the example configution file:

cp config/config.example.yml config/config.yml
Create the database:
bundle exec rake db:create
Initialize your database:
bundle exec rake db:schema:load
Run Sphinx index:
bundle exec rake ts:index
Start the Sphinx daemon:
bundle exec rake ts:start
Invoke the delayed job worker:
bundle exec rake jobs:work
In a new console, open the project root folder and start the server. The simplest way is to use the included Webrick server:
bundle exec rails server
Congratulations! Sharetribe should now be up and running for development purposes. Open a browser and go to the server URL (e.g. http://lvh.me:3000). Fill in the form to create a new marketplace and admin user. You should be now able to access your marketplace and modify it from the admin area.

Mailcatcher

Use Mailcatcher to receive sent emails locally:

Install Mailcatcher:
gem install mailcatcher
Start it:
mailcatcher
Add the following lines to config/config.yml:
development:
  mail_delivery_method: smtp
  smtp_email_address: "localhost"
  smtp_email_port: 1025
Open http://localhost:1080 in your browser
Database migrations

To update your local database schema to the newest version, run database migrations with:

bundle exec rake db:migrate
Running tests

Tests are handled by RSpec for unit tests and Cucumber for acceptance tests.

Navigate to the root directory of the sharetribe project
Initialize your test database:
bundle exec rake test:prepare
This needs to be rerun whenever you make changes to your database schema.

If Zeus isn't running, start it:
zeus start
To run unit tests, open another terminal and run:
zeus rspec spec
To run acceptance tests, open another terminal and run:
zeus cucumber
Note that running acceptance tests is slow and may take a long time to complete.

To automatically run unit tests when code is changed, start Guard:

bundle exec guard
Setting up Sharetribe for production

Before starting these steps, perform steps 1-5 from above.

Set secret_key_base
Generate secret key

rake secret
Add the following lines to config/config.yml:

production:
  secret_key_base: # add here the generated key
(You can also set the secret_key_base environment variable, if you don't want to store the secret key in a file)

Create the database:
bundle exec rake RAILS_ENV=production db:create
Initialize your database:
bundle exec rake RAILS_ENV=production db:schema:load
Run Sphinx index:
bundle exec rake RAILS_ENV=production ts:index
Start the Sphinx daemon:
bundle exec rake RAILS_ENV=production ts:start
Precompile the assets:
bundle exec rake assets:precompile
Invoke the delayed job worker:
bundle exec rake RAILS_ENV=production jobs:work
In a new console, open the project root folder and start the server:
bundle exec rails server -e production
The built-in WEBrick server (which was started in the last step above) should not be used in production due to performance reasons. A dedicated HTTP server such as unicorn is recommended.

It is not recommended to serve static assets from a Rails server in production. Instead, you should use a CDN (Content Delivery Network) service, such as Amazon CloudFront. To serve the assets from the CDN service, you need to change the asset_host configuration in the the config/config.yml file to point your CDN distribution.

For production use we recommend you to upgrade only when new version is released and not to follow the master branch.
