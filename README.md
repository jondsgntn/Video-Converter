# [RUBY] Video Converter

Simple Ruby script for mass converting `.mov` files to web optimized `.mp4` and `.webm` files

Make sure `mov/`, `mp4/`, and `webm/` directories all exist.

Take original .mov files and place them in `mov/` directory.

Before running the script, run these commands:

`gem install streamio-ffmpeg`

and

`gem install ruby-progressbar`

Once dependencies are installed and .mov files are in the correct directory, make sure you're in the project's root directory and run:

`ruby script.rb`