require "open-uri"
require "time"

class Main
  def initialize
    @id_regex = Regexp.new("<yt:videoId>(?<id>.*)<\/yt:videoId>")
    @time_regex = Regexp.new("<published>(?<published>.*)<\/published>")
    @videos = []
    @channel_list = File.readlines("channel_list.txt")
    @entry = false
    @last_sync_time = Time.parse(File.read("time.txt"))
    puts @last_sync_time.inspect
  end

  def run
    @channel_list.each do |channel|
      feed = make_feed(channel)
      puts feed
      feed = dl_feed(feed)
      # feed = File.read("videos.xml")
      get_videos(feed)
      dl_videos
    end
    update_sync_time
  end

  def update_sync_time
    File.open("time.txt", "w") { |file| file.write("#{Time.now.to_s}\n") }
  end

  def make_feed(channel)
    channel = channel.split("#")[0]
    type, id = channel.split("/")
    case type
    when "channel"
      return "https://www.youtube.com/feeds/videos.xml?channel_id=#{id}"
    when "user"
      return "https://www.youtube.com/feeds/videos.xml?user=#{id}"
    end
  end

  def dl_feed(feed)
    open(feed)
  end

  def get_videos(feed)
    entry = false
    id = nil
    published = nil
    feed.each_line do |line|
      if entry
        if line.include?("<yt:videoId>")
          id = @id_regex.match(line)[:id]
        end
        if line.include?("<published>")
          published = Time.parse(@time_regex.match(line)[:published])
        end
        if id and published
          @videos << {id: id, published: published}
          id = nil
          published = nil
        end
      end
      entry = true if line.strip == "<entry>"
    end
  end

  def dl_videos
    @videos.each do |video|
      if video[:published] > @last_sync_time
        if check_video(video[:id]) == false
          system("youtube-dl #{video[:id]}")
          add_to_db(video[:id])
          puts "ADDED TO DB"
        end
      end
    end
  end

  def check_video(id)
    dldb = File.readlines("dldb.txt").reverse
    return dldb.include?("#{id}\n")
  end

  def add_to_db(id)
    File.open("dldb.txt", "a") { |file| file.write("#{id}\n") }
  end
end

Main.new.run
