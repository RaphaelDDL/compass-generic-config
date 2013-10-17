[compass-generic-config](http://raphaelddl.github.io/compass-generic-config)
======================

Easy editable config.rb file for Compass

##Folder Structure used as Base

	root (where config.rb has to be put)
	|-- user_css_folder
	|    |-- user_fonts_folder
	|    +-- user_sass_folder
	|         +-- user_sasscache_folder
	|-- user_css_folder
	|-- user_image_folder
	+-- user_javascript_folder

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


##Configuration


#### Step 0
Put `config.rb` on your project's root folder.


#### Step 1
Configure your folder's names. E.g.:

	user_css_folder = 'css'
	user_fonts_folder = 'fonts'
	user_sass_folder = 'sass'
	user_sasscache_folder = '_cache' //sass default is '.sass-cache'
	user_image_folder = 'img'
	user_javascript_folder = 'js'


#### Step 2
Configure your environment's type. E.g.:

	user_environment = 'dev' ##or 'prod'. Defaults to prod if wrote wrong

 	user_sourcemaps = false ##or true. Defaults to false
 	##if using sprite gen, source will fail (as will cacheburst)

#### Step 3
Run `compass watch` from your Ruby prompt *or any other tool that do the same ([Prepros](http://alphapixels.com/prepros/) with Full Compass Support on, for e.g.)*


#### Step 4
Profit (?!)


##Knows Issues
Compass Sprites using something like `@import "{folderName}/*.png"; @include all-{folderName}-sprites;` give `#public_url` error and sourcemaps will fail to be created/updated. Use `user_sourcemaps = false` to prevent that.


##Etc
Got suggestions, Bugs, whatever? Feel free to make an Issue or Pull Request.


Thanks to:
* People who made Sass and Compass ([nex3](http://nex-3.com/) and [Chris](http://chriseppstein.github.com/) <3)
* [Peter J Langley](http://www.codechewing.com/library/automatically-generate-css-sprites-with-sass/) for his sprite hash remover script used as base (as well as the tutorial itself. Go read the link, it's good :D)
* You who read, use and/or help make it better
