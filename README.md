[compass-generic-config](http://raphaelddl.github.io/compass-generic-config)
======================

Easy editable config.rb file for Compass, now optionally integrated with Gruntjs and entirely configurable via package.json + grunt tasks.

**Important**
Got suggestions, Bugs, whatever? Feel free to make an Issue or Pull Request, it's a pleasure to receive them.

------

#### Changelog
* 0.5.1 - Implemented user_assets_folder, changed user_fonts_folder to assets' root, like most applications normally do, revamped Readme to reflect the changes
* 0.4 - Revamped config, now integrated with Grunt.js
* 0.3 - Added `user_sourcemaps`
* 0.2 - Added `user_environment` instead of direct changes on `environment` setting.
* 0.1 - Initial

------

## Gruntjs Integration

If you already use Grunt for your project, having sass/compass is really simple. Add `folderConfig` and the `user_xxxx_folder` like on my `package.json` file. That will guide not only config.rb itself but also `Gruntfile.js` if you are using my example settings for `grunt-contrib-compass`.

If you don't use Grunt.js, just get `package.json` and `config.rb`, editting `folderConfig` accordingly. The only thing you will need is to uncomment the `enviroment` var on `config.rb` - which if used in conjunction with Grunt, it's configured `on Gruntfile.js`, like my example task). The values for that var can be `:development` or `:production`.

------

##Folder Structure used as Base

	root (where package.json/config.rb/Gruntfile.js has to be put)
	+--user_assets_folder
		|-- user_fonts_folder
		|-- user_image_folder
		|-- user_javascript_folder
		+-- user_css_folder
			+-- user_sass_folder
				+-- user_sasscache_folder


For more info, please refeer to the `sampleRoot` folder.

------

##Development Environment Specifics

* Expanded Output;
* Line comments;
* Create sourcemaps for all `.css` files as `.css.map`, used on Chrome DevTools for better CSS debug;
(requires latest `sass bleeding edge` and latest `compass-sourcemaps` for `:development`'s sourcemaps to work)

##Production Environment Specifics

* Compressed Output;
* No line comments;
* Disable sourcemaps and remove all already created sourcemaps so they are not uploaded by mistake;

##Both Environments

####Compass sprite generation
Compass creates a new sprite file everytime there's a change, by appending a hash to the filename. For TFS and other source controls, this is a pain (having to include/delete images all time from project), therefore:

* sprites without hash on name  - name always the same (`icon-sprites.png` for e.g.);
* Hash used as cachebuster instead (`icon-sprites.png?v=9999999` for e.g.)

------

##Configuration


#### Step 0
Put `config.rb`, `Gruntfile.js` and `package.json` on your project's root folder.


#### Step 1
Configure your folder's names. E.g.:

	user_assets_folder = 'assets'
	user_css_folder = 'css'
	user_fonts_folder = 'fonts'
	user_sass_folder = 'sass'
	user_sasscache_folder = '_cache' //sass default is '.sass-cache'
	user_image_folder = 'img'
	user_javascript_folder = 'js'


#### Step 2
Run your grunt's environment type, considering you are using my tasks. E.g.:

For a watch (just like `compass watch`):

	grunt dev

For run-once compile:

	grunt compass:prod


#### Step 3

Profit (?!)


##Knows Issues
Compass Sprites using something like `@import "{folderName}/*.png"; @include all-{folderName}-sprites;` give `#public_url` error and sourcemaps will fail to be created/updated. Set `user_sourcemaps` to `false` on `package.json` to prevent that.

------

####Thanks to:
* You who read, use and/or help make it better by pushing things or creating issues
* People who made Sass and Compass - [nex3](http://nex-3.com/) and [Chris](http://chriseppstein.github.com/) - and who contributed to it
* People who made [Gruntjs](http://gruntjs.com) and who contributed to it
* [Peter J Langley](http://www.codechewing.com/library/automatically-generate-css-sprites-with-sass/) for his sprite hash remover script used as base (as well as the tutorial itself. Go read it, it's good :D)
