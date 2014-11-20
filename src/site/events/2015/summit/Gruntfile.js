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
          src: [
            'index.html'
          ],
          dest: 'get-involved/'
        },{
          expand: true,
          cwd: 'src/',
          src: [
            'index.html'
          ],
          dest: 'attendee-information/'
        },{
          expand: true,
          cwd: 'src/',
          src: [
            'index.html'
          ],
          dest: 'about-dart-summit/'
        },{
          expand: true,
          cwd: 'src/',
          src: [
            'index.html'
          ],
          dest: 'schedule/'
        }]
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
