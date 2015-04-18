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
###Environment Variables
As it's deployed to heruko, environment variables are used for config data. Ensure the local .env file has the following variables:

* FROM_EMAIL
* TO_EMAIL

###Adding a new sass file
Create .sass file in public/images/sass and import it at the end of layout.sass.