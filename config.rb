####################################
# GitHub Repo                      #
# https://github.com/RaphaelDDL/compass-generic-config
# MIT LICENSE                      #
# https://github.com/RaphaelDDL/compass-generic-config/blob/master/LICENSE
####################################
# COMPASS CONFIG                   #
#           ---------              #
# PUT config.rb ON PROJECT ROOT    #
####################################

##================================##
# STEP 1                           #
##================================##
# CONFIGURE YOUR FOLDER NAMES      #
##================================##
user_css_folder = 'css'
user_fonts_folder = 'fonts'
user_sass_folder = 'sass'
user_sasscache_folder = '_cache'
user_image_folder = 'img'
user_javascript_folder = 'js'

# FOLDER STRUCTURE EXAMPLE
#
# root
# |-- user_css_folder
# |    |-- user_fonts_folder 
# |    +-- user_sass_folder 
# |         +-- user_sasscache_folder 
# |-- user_css_folder
# |-- user_image_folder
# +-- user_javascript_folder

##================================##
# STEP 2                           #
##================================##
# 'dev' for DEVELOPMENT            #
# OR                               #
# 'prod' for PRODUCTION            #
##================================##
user_environment = 'dev'


########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
# DO NOT MODIFY BELOW ~~ DO NOT MODIFY BELOW ~~ DO NOT MODIFY BELOW    #
########################################################################
########################################################################
########################################################################
########################################################################
########################################################################
# General
relative_assets = true
project_path = File.dirname(__FILE__) + '/'


# Sass Paths
http_path = '/'
http_javascripts_path = user_javascript_folder
http_stylesheets_path = user_css_folder
http_generated_images_path = user_image_folder
http_images_path = user_image_folder
http_fonts_path = http_stylesheets_path + '/' + user_fonts_folder
cache_path = project_path + user_css_folder + '/' + user_sass_folder + '/' + user_sasscache_folder

# Sass Directories
javascripts_dir = user_javascript_folder
css_dir = user_css_folder
sass_dir = css_dir + '/' + user_sass_folder
images_dir = user_image_folder
generated_images_dir = user_image_folder
fonts_dir = css_dir + '/' + user_fonts_folder
cache_dir = sass_dir + '/' + user_sasscache_folder

# Environment Rules
if user_environment == 'dev'
	p '##================================##'
	p 'Development Environment'
	p '##================================##'
	p ' '
	environment == :development
	output_style = :expanded
	line_comments = true
	sass_options = {:sourcemap => true, :cache_location => cache_dir }
	enable_sourcemaps = true 

else
	p '##================================##'
	p 'Production Environment'
	p '##================================##'
	p ' '
	environment == :production
	output_style = :compressed
	line_comments = false
	sass_options = { :cache_location => cache_dir }
	enable_sourcemaps = false
	
	on_stylesheet_saved do |filename|
		if File.exists?(filename)
			#Removing development sourcemap file
			FileUtils.rm_rf(filename + '.map')
		end
	end
end

# COMPASS SPRITE CONFIG
# Make a copy of sprites with a name that has no uniqueness of the hash.
on_sprite_saved do |filename|
	if File.exists?(filename)
		FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
		FileUtils.rm_rf(filename)
	end
end
# Replace in stylesheets generated references to sprites
# by their counterparts without the hash uniqueness.
on_stylesheet_saved do |filename|
	if File.exists?(filename)
		css = File.read filename
		File.open(filename, 'w+') do |f|
			f << css.gsub(%r{(?<start>-s)(?<hash>[a-z0-9]{10})(?<file>\.png)}, '.png?v=\k<hash>')
		end
	end
end
