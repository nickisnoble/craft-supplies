# Craft Supplies

A boilerplate for new Craft CMS projects. Uses Homestead, Gulp, and Capistrano.

## Installation

Wait till each step is complete before moving on to the next!

### [other than node] Dev Prerequisites

1. Install [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/)
1. Install homestead: `$ vagrant box add laravel/homestead`
1. Make it executable `$ composer global require “laravel/homestead=~2.0"`
1. `$ homestead init`
1. configure your homestead settings:
  1. open `~/.homestead/Homestead.yaml`
  1. add the paths to your public key under `keys` and private key under `authorize`

### Local setup

1. clone this repo
1. get the latest version of Craft
  1. run ``
1. run `$ npm install && bower install`
1. create a local mysql db
1. update your homestead settings:
  1. open `~/.homestead/Homestead.yaml`
  1. add the folders (adjust paths to match your setup), local url, and database for the site (see example below)
1. add `192.168.56.102 yoursite.dev` to `/etc/hosts`
1. launch the vagrant box `homestead up`
1. go to [the site admin](http://yoursite.dev/admin) in your browser. If you see a monkey, Craft is working!

```
// Example homestead.yaml snippet

...
authorize: ~/.ssh/id_rsa.pub

keys:
    - ~/.ssh/id_rsa

folders:
    - map: ~/Sites/yoursite.com
      to: /home/vagrant/Sites/yoursite.com

sites:
    - map: yoursite.dev
      to: /home/vagrant/Sites/yoursite.com/public/

databases:
    - yoursite
...
```

## Deployment

### Server Setup

1. Verify db credentials in `cap/deploy.rb` `cap/deploy/production.rb`
1. *optional:* setup the server `$ cap production craft:setup`

### Deploying

`$ git checkout master && cap production deploy`

### Sycing things

### Tasks

Alongside Capistrano's [various tasks](http://capistranorb.com/), there are some useful commands for working with Craft websites. Most of the credit for this goes to [Bluegg](https://github.com/Bluegg/craft-deploy), though I've made some minor tweaks and additions.

#### Databases

Craft deploy can push and pull databases (via mysqldump) between environments. Please note that this is a total replacement of the db.

```sh
cap production db:push
```

or

```sh
cap production db:pull
```

#### Assets

Craft Deploy uses rsync to synchronise assets and font files between enviroments:

```sh
cap production craft:sync_assets
```

For convenience, you can push or pull both databases and sync assets with a single command:

```sh
cap production craft:push
```

```sh
cap production craft:pull
```

## Contributing

1. Create your feature branch: `git checkout -b my-new-feature`
1. Commit your changes: `git commit -am 'Add some feature'`
1. Push to the branch: `git push origin my-new-feature`
1. Submit a pull request :D