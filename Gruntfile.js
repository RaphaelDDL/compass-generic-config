//* ========================
//compass-generic-config
//Version: 0.4
//Author: RaphaelDDL
//Github: https://github.com/RaphaelDDL/compass-generic-config
//MIT LICENSE
//https://github.com/RaphaelDDL/compass-generic-config/blob/master/LICENSE
//======================== */

//* =============================================
//Section: Grunt Configuration
//================================================ */
module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		//* =============================================
		//Section: SASS/COMPASS
		//================================================ */
		compass: {
			options: {
				config: './config.rb',
				watch: false
			},
			dev: {
				options: {
					environment: 'development'
				}
			},
			prod: {
				options: {
					environment: 'production'
				}
			}
		},

		//* =============================================
		//Section: WATCH
		//================================================ */
		watch: {
			compassdev: {
					files: [
						'<%= pkg.folderConfig.user_assets_folder %>/<%= pkg.folderConfig.user_css_folder %>/<%= pkg.folderConfig.user_sass_folder %>/**/*.scss'
					],
					tasks: ['compass:dev']
			},
			compassprod: {
				files: [
					'<%= pkg.folderConfig.user_assets_folder %>/<%= pkg.folderConfig.user_css_folder %>/<%= pkg.folderConfig.user_sass_folder %>/**/*.scss'
				],
				tasks: ['compass:prod']
			}
		},

	}); //grunt.initConfig

	//* =============================================
	//Section: TASK LOADER
	//================================================ */
	grunt.loadNpmTasks('grunt-contrib-compass');
	grunt.loadNpmTasks('grunt-contrib-watch');


	//* =============================================
	//Section: REGISTER TASKS
	//================================================ */
	grunt.registerTask("dev", ["watch:compassdev"]);
	grunt.registerTask("prod", ["watch:compassprod"]);

	// the default task can be run just by typing "grunt" on the command line
	grunt.registerTask('default', 'compass:prod']);
}//module.exports
