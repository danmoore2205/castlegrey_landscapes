# Castlegrey Landscapes Website
----
##Development
###Start the server
It's setup to run with foreman.

    foreman start
###Debugging
Use pry-remote to debug with foreman

    binding.pry_remote

Then once you hit the breakpoint run pry-remote from the command line

    pry-remote
###Resizing images
The images on the portfolio page are resized to have a width of 300px. This reduces their file size without compromising the view quality. To resize an image from the command line, ensure imagemagick is installed and run the following command.

    convert path_to_image -resize 300 output_path_to_image

###Environment Variables
As it's deployed to heroku, environment variables are used for config data. Ensure the local .env file has the following variables:

* FROM_EMAIL
* TO_EMAIL

###Adding a new sass file
Create .sass file in public/images/sass and import it at the end of layout.sass.

###Heroku Commands
Deploy a branch
    git push local_branch_name:master