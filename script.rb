#require dependencies
require 'streamio-ffmpeg'
require 'ruby-progressbar'

#get list of .mov files from mov/ directory
videos = Dir["mov/*.{mov,MOV}"]

#run through list of files
videos.each do |video|
  #get base filename
  filename = File.basename(video, ".*")

  #initiate new conversion of .mov file
  movie = FFMPEG::Movie.new(video)

  #set options for mp4 conversion
  mp4_options = {video_min_bitrate: 1200,
             video_max_bitrate: 1200,
             buffer_size: 2000,
             resolution: "1920x1080",
             video_codec: "h264",
             video_stream: "h264",
             frame_rate: 60,
             custom: %w(-strict -2)}

  #set options for webm conversion
  webm_options = {video_min_bitrate: 2400,
             video_max_bitrate: 2400,
             buffer_size: 3900,
             resolution: "1920x1080",
             video_codec: "libvpx",
             frame_rate: 60}

  #convert mov to mp4
  mp4_progressbar = ProgressBar.create(:title => "Converting #{filename} to MP4", :starting_at => 0, :total => 100)
  i=0
  movie.transcode("mp4/#{filename}.mp4", mp4_options) { |progress| (progress*100).to_i >= i+1 ? ((progress*100).to_i-i).times { mp4_progressbar.increment } && i=(progress*100).to_i : '' }

  #convert mov to webm
  webm_progressbar = ProgressBar.create(:title => "Converting #{filename} to WEBM", :starting_at => 0, :total => 100)
  i=0
  movie.transcode("webm/#{filename}.webm", webm_options) { |progress| (progress*100).to_i >= i+1 ? ((progress*100).to_i-i).times { webm_progressbar.increment } && i=(progress*100).to_i : '' }
end