/**
 * Copyright 2014 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module.exports = function(grunt) {

  grunt.initConfig({

    pkg: grunt.file.readJSON('package.json'),

    /** Setup tasks **/

    clean: {
      dist: ["static", "index.html", "sw.js"],
      concatenatedjsfile: ["src/static/scripts/cds.concat.js"]
    },

    copy: {
      build: {
        files: [{
          expand: true,
          cwd: 'src/',
          src: [
            '**',
            '!static/scripts/**/*.js',
            '!static/styles/**/*.scss'
          ],
          dest: './'
        }]
      },

      serviceWorker: {
        files: [{
          expand: true,
          cwd: 'src/',
          src: [
            'static/scripts/third_party/**/*.js',
            'static/scripts/sw.js'
          ],
          dest: './'
        }]
      },

      html: {
        files: [{
          expand: true,
          cwd: 'src/',
          src: [
            '**/*.html'
          ],
          dest: './'
        }]
      },

      fakeCardsHtml: {
        files: [{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'get-involved/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'attendee-information/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'about-dart-summit/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'schedule/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/async-in-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/how-we-built-instill-io-with-dart-and-polymer/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/panel/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/building-production-dart-apps-with-a-pure-open-source-workflow/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/dart-at-60fps/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/dart-for-internet-of-things/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/dart-for-mobile/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/dart-for-the-web-state-of-the-union/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/debugging-and-profiling-dart-programs-with-observatory/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/getting-the-most-out-of-dart2js/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/google-fiber-and-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/keynote/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/keynote-ads-and-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/migrating-trustwaves-large-customer-portal-to-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/moving-from-node-js-to-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/sky/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/space-frugal-reflection/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/switching-to-dart/'
        },{
          expand: true,
          cwd: 'src/',
          src: 'index.html',
          dest: 'sessions/lightning-talks/'
        }
        ]
      }
    },

    concurrent: {
      options: {
        logConcurrentOutput: true
      },
      build: {
        tasks: ['watch:notjsorcss', 'watch:js', 'watch:scss']
      }
    },

    watch: {
      notjsorcss: {
        files: [
          'src/**/*.*',
          '!src/scripts/*.*',
          '!src/styles/*.*'
        ],
        tasks: ['copy:html']
      },
      js: {
        files: [
          'src/static/scripts/**/*.js',
          '!src/static/scripts/cds.concat.js'
        ],
        tasks: ['codekit', 'uglify', 'copy:serviceWorker']
      },
      scss: {
        files: ['src/static/styles/**/*.scss'],
        tasks: ['sass']
      }
    },

    /** JavaScript **/

    codekit: {
      build: {
        files: {
          'src/static/scripts/cds.concat.js':
          'src/static/scripts/cds.js'
        }
      }
    },

    uglify: {
      options: {
        sourceMap: true
      },
      build: {
        src: 'src/static/scripts/cds.concat.js',
        dest: 'static/scripts/cds.min.js'
      }
    },

    /** CSS **/

    sass: {
      build: {
        options: {
          outputStyle: 'compressed',
          sourceMap: false
        },
        files: [{
          expand: true,
          cwd: 'src/static/styles/',
          src: ['cds.scss', 'reg-form.scss'],
          dest: 'static/styles/',
          ext: '.min.css'
        }]
      }
    },

    /** Images **/

    imageoptim: {
      options: {
        jpegMini: false,
        imageAlpha: false,
        imageOptim: true,
        quitAfter: true
      },
      build: {
        src: [
          'static/**/*.png',
          'static/**/*.jpg',
          'static/**/*.gif'
        ]
      }
    },

    /** Licensing **/

    usebanner: {
      html: {
        options: {
          banner: '<!-- For licensing see /devsummit/LICENSE -->'
        },
        files: {
          src: 'dist/**/*.html'
        }
      },
      jscss: {
        options: {
          banner: '/*! For licensing see /devsummit/LICENSE */'
        },
        files: {
          src: ['static/**/*.css', 'static/**/*.js']
        }
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-codekit');
  grunt.loadNpmTasks('grunt-sass');
  grunt.loadNpmTasks('grunt-imageoptim');
  grunt.loadNpmTasks('grunt-banner');

  grunt.registerTask('dev', [
    'clean:dist',
    'copy',
    'codekit',
    'uglify',
    'clean:concatenatedjsfile',
    'sass',
    'concurrent']);

  grunt.registerTask('full', [
    'clean:dist',
    'copy',
    'codekit',
    'uglify',
    'clean:concatenatedjsfile',
    'sass',
    'imageoptim',
    'usebanner']);

  grunt.registerTask('default', [
    'clean:dist',
    'copy',
    'codekit',
    'uglify',
    'clean:concatenatedjsfile',
    'sass',
    'usebanner']);
};
