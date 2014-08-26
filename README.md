# Mampf-Cordova-Superteam-9000


## Installation

* Npm (~>1.4.14) + Node (~> 0.10.29)
* `npm i -g gulp coffeeify browserify bower`
* Cordova (~> 3.5.0)
* Ios SDK+Sim for IOS / Android ADT for Android

Run `gulp` from project directory for serve/jade/coffee/sass/bower/browsersync

Run `gulp build` for building, i.e. copying content into www/


## Development

First make sure to install all dependencies:

* `npm install` from project directory for gulp environment
* `bower install` from project directory for clientside dependencies (i.e. angular)

## GH-Pages

To push to Gh-pages, push the www folder with git subtree to gh-pages branch, i.e. create a bash function:

```
function subtree_push() {
  git subtree push --prefix $1 origin gh-pages
}
alias gpages=subtree_push
```
Usage: `gpages www` inside project root


