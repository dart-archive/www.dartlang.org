# The OLD Dart Website (OBSOLETE)

The contents of the old dartlang.org website are now in 3 places:

* www.dartlang.org (github.com/dart-lang/site-www)
* [webdev.dartlang.org](http://webdev.dartlang.org) (github.com/dart-lang/site-webdev)
* [events.dartlang.org](http://events.dartlang.org) (github.com/dart-lang/site-events)

-----------------

This repo has the code for the former www.dartlang.org site. Built with
[Jekyll](https://github.com/mojombo/jekyll)
and hosted on App Engine.

## Orientation

<dl>
  <dt> ./src </dt>
  <dd> All the working files. </dd>

  <dt> ./src/appengine </dt>
  <dd> App engine configuration files. </dd>

  <dt> ./src/diagrams </dt>
  <dd> Omnigraffle files, mostly.
  We don't publish these on the site, but we need to keep them around
  in case we need to edit a diagram or create a similar diagram. </dd>

  <dt> ./src/site </dt>
  <dd> Documents, HTML files, images, etc.
  You work out of here normally. </dd>

  <dt> ./src/tests </dt>
  <dd> Code that's featured in the site's pages,
  placed here so it can be tested automatically
  without being copied to the site. </dd>

  <dt> ./build </dt>
  <dd> Generated by Jekyll, to be deployed to server.
  This directory is transient; you can delete it. </dd>
</dl>


## Configuring your system

* If you're using a Mac, make sure you have Xcode.
* Ensure you have Ruby 1.9.3 or 2.0.
* Ensure you have Python 2.7.
* In a terminal, from the dartlang.org project root:
  1. Run `sudo gem install fast-stemmer -v '1.0.2'`
  2. Run `sudo gem install bundler`
  3. Run `bundle install`, which installs the gems listed in `Gemfile`
    (liquid, jekyll, etc.).
* Get the Dart SDK, if you don't already have it, and make sure `pub` is in your path.
* Download and install the
  [Google App Engine SDK for Python](https://developers.google.com/appengine/downloads)
* Ask an admin to invite you to modify the Dart project on the Google App Engine.

### Tips for Mac
* You might want the binary install of
    [Python 2.7.3](http://www.python.org/download/releases/2.7.3/)
* Ensure App Engine is using Python 2.7. You will see "you're using 2.6" in
  the log if it is not.
  * You can go to Preferences and enter the direct
    path to the Python 2.7 binary. For example:
    `/Library/Frameworks/Python.framework/Versions/2.7/bin/python2.7`.

### Tips for Windows

* Install Python with the [Windows installer](https://www.python.org/download/windows/) or `choco install python2`.
* Install Ruby with the [RubyInstaller site](http://rubyinstaller.org/downloads/) or `choco install ruby`.
* Install the Ruby DevKit from the [RubyInstaller site](http://rubyinstaller.org/downloads/) or `choco install ruby2.devkit`.
* Run `gem install bundler`.
* Run `bundle install` from the root of your dartlang project.


### GitHub setup

* Create a [GitHub login](https://github.com/join) login if you don't already have one.
* Ask an admin to invite you to the dart-lang project on GitHub.


### Contributing via Chromium Code Review

On a Mac:
* Make sure you have Xcode (contains git)
* Install depot_tools:
  $ git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
* Add depot_tools to your PATH:
  $ export PATH="$PATH":`pwd`/depot_tools
  NOTE: You may want to add this to your .bashrc file or your shell's equivalent so that you don’t need to reset your $PATH manually each time you open a new shell.
* Run `git cl config`. For the Rietveld server, specify `https://chromiumcodereview.appspot.com`.
  * If you haven't used http://chromiumcodereview.appspot.com/ before, you'll be asked to specify an
    [app-specific password](http://www.google.com/support/accounts/bin/answer.py?answer=185833).
    Go ahead and create one. Your regular password won't work.

## Development

* Open a terminal to the root of this project.
* Run the server with `make server`, and leave it running while you edit files.
* Your web browser opens to http://localhost:8081.
  * You may need to reload once.
* Edit, create docs as normal.
* To run tests, run `./runtests.sh`.

**Note:** If you see single-page breadcrumbs on pages such as
http://localhost:8081/tools/pub/cmd/pub-build.html, make sure that you've
installed the latest gem versions.
(Run `sudo bundle install` and then `bundle install`.)


### Windows development tips

You probably won't have **make** available on the command line by default.

* To just get up and running, run `jekyll serve` from the `src/site` folder.
* This starts up the Jekyll webserver and generates into `build/static`.
* If Jekyll does not generate output, you need to type `chcp 65001` at the
  command prompt to change the code page to UTF-8.
  (Jekyll fails silently if this is not done.)
* To **clean**, simply delete the contents of `build/static` and restart `jekyll`.


## Release testing

There is a `sanity-test` target that tests some very basic features of
dartlang.org with some browser tests:

```bash
# launch the local copy of dartlang.org with `jekyll serve`, and test it:
make sanity-test

# test against the live dartlang.org site:
make sanity-test-live

# test against any staged copy of dartlang.org:
bundle exec ruby src/tests/site/sanity.rb <URL>
```


## Deploying the site

* Run `make deploy`.
  * This builds the site, placing everything into `build/`, and then deploys
    the site. (Note: You can also run `make build` and then deploy manually
    using App Engine.)
  * This command uses the current branch for the App Engine version name.
    If you need to change the version name, create a new local branch that has
    the name you want—for example, prod-style-guide-update. Switch to that
    branch and, after making sure it has all the changes you need, run `make
    deploy`.
    (This matters because at least one external program relies on the App Engine
    version matching the text in www.dartlang.org/release.txt, and the contents
    of /release.txt are generated using the name of the current branch.)
  * If you see the error `/bin/sh: appcfg.py: command not found`, try launching
    GoogleAppEngineLauncher. If it hasn't yet set up links for its commands,
    it'll automatically do so, fixing the problem.
* You will probably need to generate an
  [App-specific password](https://sites.google.com/a/google.com/second-factor/application-specific-passwords-faq).
  Save this password into the App Engine Launcher during the first deployment.
