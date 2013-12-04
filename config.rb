#================================================#
#compass-generic-config
#Version: 0.4
#Author: RaphaelDDL
#Github: https://github.com/RaphaelDDL/compass-generic-config
#MIT LICENSE
#https://github.com/RaphaelDDL/compass-generic-config/blob/master/LICENSE
#================================================#

#uncomment below if you are not using gruntjs
#environment = :development

#================================================#
#Section: Open and Read 'package.json'           #
#================================================#
begin
	require 'open-uri'
	require 'json'

	packOpen = open('package.json', "UserAgent" => "Ruby-Wget").read
	packJson = JSON.parse(packOpen) # convert JSON data into a hash
	folderConfig = packJson['folderConfig']
rescue
	abort("Error trying to read 'package.json'. Make sure you have one and have your 'folderConfig' configured. Also check if your Ruby have 'open-uri' and 'json' and can use them.")
end

#================================================#
#Section: Default Properties                     #
#================================================#
project_type = :stand_alone
relative_assets = true
disable_warnings = false
preferred_syntax = :scss
sprite_engine = :chunky_png
chunky_png_options = {:compression => Zlib::BEST_COMPRESSION}

#================================================#
#Section: Http Paths                             #
#================================================#
http_path = folderConfig['user_http_path']
http_javascripts_path = http_path + '/' + folderConfig['user_assets_folder'] + '/' + folderConfig['user_javascript_folder']
http_stylesheets_path = http_path + '/' + folderConfig['user_assets_folder'] + '/' + folderConfig['user_css_folder']
http_fonts_path = http_path + '/' + folderConfig['user_assets_folder'] + '/' + folderConfig['user_fonts_folder']
http_images_path = http_path + '/' + folderConfig['user_assets_folder'] + '/' + folderConfig['user_image_folder']
http_generated_images_path = http_images_path

#================================================#
#Section: Compass Directories                    #
#================================================#
javascripts_dir = folderConfig['user_assets_folder'] + '/' + folderConfig['user_javascript_folder']
css_dir = folderConfig['user_assets_folder'] + '/' + folderConfig['user_css_folder']
images_dir = folderConfig['user_assets_folder'] + '/' + folderConfig['user_image_folder']
generated_images_dir = folderConfig['user_assets_folder'] + '/' + folderConfig['user_image_folder']
fonts_dir = folderConfig['user_assets_folder'] + '/' + folderConfig['user_fonts_folder']
sass_dir = css_dir + '/' + folderConfig['user_sass_folder']
cache_dir = sass_dir + '/' + folderConfig['user_sasscache_folder']

#================================================#
#Section: Compass Paths                          #
#================================================#
project_path = File.realpath(File.join(File.dirname(__FILE__)))

javascripts_path = project_path + '/' + javascripts_dir
fonts_path = project_path + '/' + fonts_dir
css_path = project_path + '/' + css_dir
sass_path = project_path + '/' + sass_dir
cache_path = project_path + '/' + cache_dir
images_path = project_path + '/' + images_dir
generated_images_path = images_path
sprite_load_path = images_path

#================================================#
#Section: Environment Rules                      #
#================================================#
if (defined?(environment)) && environment != nil
	environment = :production
	puts "WARNING: environment property not set, using :production as default.\n"
end

if environment == :development
	output_style = :expanded
	line_comments = true
	if folderConfig['user_sourcemaps'] == "true" || folderConfig['user_sourcemaps'] == true
		enable_sourcemaps = true
		sass_options = {:sourcemap => true, :cache_location => cache_dir }
	else
		enable_sourcemaps = false
		sass_options = { :cache_location => cache_dir }
	end

else
	output_style = :compressed
	line_comments = false
	sass_options = { :cache_location => cache_dir }
	enable_sourcemaps = false

	on_stylesheet_saved do |filename|
		if File.exists?(filename)
			FileUtils.rm_rf(filename + '.map') #Removing development sourcemap file
		end
	end
end

#================================================#
#Section: Compass Spriting Rules                 #
#================================================#
on_sprite_generated do |sprite_data|
	sprite_data.metadata['Caption'] = "©" + packJson['author']
end

on_sprite_saved do |filename|
	# Make a copy of sprites with a name that has no uniqueness of the hash
	if File.exists?(filename)
		FileUtils.cp filename, filename.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
		FileUtils.rm_rf(filename)
	end
end

on_stylesheet_saved do |filename|
	# Replace in stylesheets generated references to sprites
	# by their counterparts without the hash uniqueness.
	if File.exists?(filename)
		css = File.read filename
		File.open(filename, 'w+') do |f|
			f << css.gsub(%r{(?<start>-s)(?<hash>[a-z0-9]{10})(?<file>\.png)}, '.png?v=\k<hash>')
		end
	end
end