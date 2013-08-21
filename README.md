compass-generic-config
======================

Easy editable config.rb file for Compass
(requires latest `sass bleeding edge` and latest `compass-sourcemaps`)

###Folder Structure used as Base

	root (where config.rb has to be put)
	|-- user_css_folder
	|    |-- user_fonts_folder 
	|    +-- user_sass_folder 
	|         +-- user_sasscache_folder 
	|-- user_css_folder
	|-- user_image_folder
	+-- user_javascript_folder

###Development Environment Specifics

* Expanded Output, with line comments;
* Create sourcemaps for all `.css` files as `.css.map`, used on Chrome DevTools for better CSS debug;

###Production Environment Specifics

* Compressed Output, no line comments;
* Disable sourcemaps and remove all already created sourcemaps so they are not uploaded by mistake;

###Both Environments

######Compass sprite generation
Compass creates a new sprite file everytime there's a change, by appending a hash to the filename. For TFS and other source controls, this is a pain (having to include/delete images all time from project), therefore:

* sprites without hash on name  - name always the same (`icon-sprites.png` for e.g.);
* Hash used as cachebuster instead (`icon-sprites.png?v=9999999` for e.g.)


### Configuration
  

###### Step 0
Put `config.rb` on your project's root folder.


###### Step 1
Configure your folder's names. E.g.:

  user_css_folder = 'css'
  user_fonts_folder = 'fonts'
  user_sass_folder = 'sass'
  user_sasscache_folder = '_cache'
  user_image_folder = 'img'
  user_javascript_folder = 'js'
  
###### Step 2
Configure your environment's type. E.g.:

  environment = :development
  
###### Step 3
Run `compass watch` or any other tool that do the same (Prepros with Full Compass Support on, for e.g.)

###### Step 4
Profit.


