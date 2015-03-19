# Dart Dev Summit site

This is based on the [Chrome Dev Summit site](/GoogleChrome/devsummitsite).

1. Install node.js.
1. Install npm and sass.
1. Run `npm install`.
1. Run `grunt dev` during work and `grunt` to do a full build.
   (You can also do `grunt full` if you want to have image optimized.)

After you run `grunt dev`, open a new terminal, cd into the root
of the _www.dartlang.org_ project, and run `make server`.

Please only changes files in the src/ directory as index.html, sw.js and
files under /static and /form are generated from sources in src/
