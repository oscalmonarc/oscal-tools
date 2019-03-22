# Monarc

Monarc is an application to better manage security control implementation and verification of systems.

This is currently under development and not ready for production usage.

Monarc guides users through the security authorization process more quickly by reusing and crowdsourcing how commonly used tools and services satisfy the security controls; through a repository of profiles.




## Installation

### Required packages

 * Utilities: git, make, g++
   * CentOS: `sudo yum install git make gcc-c++`
   * Ubuntu: `sudo apt install git make g++`
 * Ruby 2.3 or higher, with dev packages
   * CentOS: `sudo yum install ruby-devel rubygem-bundler && gem install pry` (gem install may require sudo)
   * Ubuntu: `sudo apt install ruby ruby-dev pry ruby-bundler`
 * Gem dependencies: ssdeep, ImageMagick, zlib, xml dev packages
   * CentOS: `sudo yum install epel-release && sudo yum install ssdeep-devel ImageMagick-devel zlib-devel libxml2-devel`
   * Ubuntu: `sudo apt install zlib1g-dev libfuzzy-dev libxml2-dev libmagick++-dev`
 * MySQL or MariaDB, with dev packages
   * CentOS: `sudo yum install mariadb-server mariadb-devel`
   * Ubuntu: `sudo apt install mariadb-server libmariadb-client-lgpl-dev`
 * Java - version 8 preferred (see Solr notes)
   * CentOS: `sudo yum install java-1.8.0-openjdk-headless`
   * Ubuntu: `sudo apt install openjdk-8-jre-headless`
   
For Homebrew on Mac, see [these notes](https://github.com/nbgallery/nbgallery/blob/master/docs/homebrew.md).
   
### Installation

After installing the required OS packages, either clone or download the project and then run `bundle install` from the project directory.  The project is a [Ruby on Rails](http://rubyonrails.org/) app, so you can run it via `rails server` or with [Rack](https://rack.github.io/) servers like [Puma](http://puma.io/) or [Passenger](https://www.phusionpassenger.com/).

The Monarc application requires a MySQL or MariaDB server.  Other SQL-based servers may work but have not been tested.  We recommend creating a separate mysql user account for use by the app.


### Configuration

General configuration is stored in `config/settings.yml` and `config/settings/#{environment}.yml`.  Precedence of these files is defined by the [config gem](https://github.com/railsconfig/config#accessing-the-settings-object).  These files are under version control, so we recommend creating `config/settings.local.yml` and/or `config/settings/#{environment}.local.yml`, especially if you plan to contribute to the project.  At a minimum, you'll need to configure the mysql section to match your database server, but most other settings should work out of the box.

### Startup sequence

1. `bundle exec rake db:migrate` must be run whenever there are database schema changes, but it's safe to run it every time.
2. If running in production mode: `bundle exec rake assets:precompile`
3. Start the app: e.g. `rails server` or via something like puma, passenger, etc.


### Shutdown sequence

1. If running crons outside the app: `bundle exec script/cronic -k -P <piddir>/cronic.pid`
2. Stop the app

### Enviroment Variables
Make sure to set the following fields in your enviroment variables. In Linux this can be done by editing ~/.bashrc with the following, but make replace the parts between the quotes, and remove the brackets (< >).
export DB_HOST="<DB URL>"
export DB_PASSWORD="<PASSWORD>"
export DB_USER="<USERNAME>"
export DB_NAME="<DB NAME>"
export DB_TEST="<TEST DB>"
export Monarc_URL="<URL>"
export SECRET_KEY_BASE="<SECRET KEY>

### Running in docker

These are some notes on running mysql and Monarc in separate docker containers.  We have not run a production instance using docker, and these notes have not been tested in quite some time.  We welcome contributions in the form of notes, scripts, [docker compose](https://docs.docker.com/compose/) files, etc!

# Build image
```docker build -f Dockerfile -t Monarc:latest .```

# Create network (once)
```docker network create Monarc```

# Start database container
Make sure to put either the enviroment variables for each field or the actual information after the equals. dont use the default data shown.  
 ```docker run -d --network Monarc --name Monarcdb -e MYSQL_RANDOM_ROOT_PASSWORD=yes -e MYSQL_USER=Monarc -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=Monarc mariadb:10.3.9```

# Start ruby/rails container
Make sure to put either the enviroment variables for each field or the actual information after the equals. dont use the default data shown.  
 ```docker run -d --network Monarc -p 80:3000 --name Monarc -e DB_HOST="Monarcdb" -e DB_USER="Monarc" -e DB_PASSWORD=<password> -e DB_NAME="Monarc" -e Monarc_URL=<url> -e SECRET_KEY_BASE=<secret_key> Monarc:latest```

# Initial db creation (once)
```docker exec -it Monarc bundle exec rake db:setup```

# After redeploy of new Monarc container versions with schema changes (on migration)
```docker exec -it Monarc bundle exec rake db:migrate```

# To clean up and for new Monarc install
```docker stop Monarc```
```docker rm Monarc```

