# Castlegrey Landscapes Website
----
##Development
###Start the server
It's setup to run with foreman.

    foreman start

###Debugger
Use pry-remote to debug with foreman

    binding.pry_remote

Then once you hit the breakpoint run pry-remote from the command line

    pry-remote
###Adding a new sass file
Create .sass file in public/images/sass and import it at the end of layout.sass.