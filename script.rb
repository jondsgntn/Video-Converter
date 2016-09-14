require 'streamio-ffmpeg'
require 'ruby-progressbar'

mov_videos = Dir["mov/*"]
mov_videos.each do |video|
  i = video.index("/")
  j = video.index(".mov")
  filename = video[i+1..j-1]
  movie = FFMPEG::Movie.new("mov/#{filename}.mov")
  mp4_options = {video_min_bitrate: 1200,
             video_max_bitrate: 1200,
             buffer_size: 2000,
             resolution: "1920x1080",
             video_codec: "h264",
             video_stream: "h264",
             frame_rate: 60}
  webm_options = {video_min_bitrate: 2400,
             video_max_bitrate: 2400,
             buffer_size: 3900,
             resolution: "1920x1080",
             video_codec: "libvpx",
             frame_rate: 60}

  mp4_progressbar = ProgressBar.create(:title => "Converting #{filename} to MP4", :starting_at => 0, :total => 100)
  inc = 0
  movie.transcode("mp4/#{filename}.mp4", mp4_options) { |progress| progress.to_f >= inc+0.1 ? 10.times { mp4_progressbar.increment } && inc+=0.1 : '' }
  webm_progressbar = ProgressBar.create(:title => "Converting #{filename} to WEBM", :starting_at => 0, :total => 100)
  inc = 0
  movie.transcode("webm/#{filename}.webm", webm_options) { |progress| progress.to_f >= inc+0.1 ? 10.times { webm_progressbar.increment } && inc+=0.1 : '' }
end