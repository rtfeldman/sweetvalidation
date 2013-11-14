module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      scripts:
        files: '*.coffee'
        tasks: ['coffeeify']
        options: nospawn: true

    coffee:
      compile:
        files:
          'dist/sweetvalidation.js': ['src/**/*.coffee']

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script'
        src: ['test/**/*.coffee']

  [
      'grunt-contrib-coffee', 'grunt-contrib-watch', 'grunt-mocha-test'
  ].forEach grunt.loadNpmTasks

  grunt.registerTask('test', ['mochaTest'])
  grunt.registerTask('dist', ['coffee'])
  grunt.registerTask('default', ['coffee', 'watch'])