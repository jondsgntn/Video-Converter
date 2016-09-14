# [RUBY] Video Converter

Simple Ruby script for mass converting `.mov` files to web optimized `.mp4` and `.webm` files

Make sure `mov/`, `mp4/`, and `web/` directories all exist.

Take original .mov files and place them in `mov/` directory.

Before running the script, run these commands:

`gem install streamio-ffmpeg`
`gem install ruby-progressbar`

Once dependencies are installed and .mov files are in the correct directory, run:

`ruby script.rb`