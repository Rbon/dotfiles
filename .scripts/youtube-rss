#! /usr/bin/env ruby

###BUGS: If youtube-dl isn't present, the script thinks everything is fine, and
###      updates the sync dates.

require "open-uri"
require "time"
require "json"

class Main
  def initialize
    @dl_path = ARGV[0] || "."
    @channel_list = File.readlines(File.expand_path("~/.config/youtube-rss/channel_list.txt"))
    @feed_parser = FeedParser.new(
      dl_path: @dl_path,
      cache_file: File.expand_path("~/.config/youtube-rss/cache.json")
    )
  end

  def run
    YoutubeRss.new(
      channel_list: @channel_list,
      feed_parser: @feed_parser
    ).run
  end
end

class YoutubeRss
  def initialize(channel_list:, feed_parser: FeedParser.new)
    @channel_list = channel_list
    @feed_parser = feed_parser
  end

  def run
    @channel_list.each do |line|
      channel = @feed_parser.channel(line)
      puts channel.name
      channel.new_videos.each(&:download)
    end
  end
end

class FeedParser
  def initialize(channel_class: Channel, video_class: Video,
                 cache_file:, dl_path:)
    @channel_class = channel_class
    @video_class = video_class
    @tag_regex = /<(?<tag>.*)>(?<value>.*)<.*>/
    @dl_path = dl_path
    @cache_file = cache_file
    @feed_types = {
      channel: "https://www.youtube.com/feeds/videos.xml?channel_id=%s",
      user: "https://www.youtube.com/feeds/videos.xml?user=%s"
    }
  end

  def channel(url)
    url = url.split("#")[0].strip
    type, id = url.split("/")
    feed = open(@feed_types[type.to_sym] % id) { |io| data = io.read }
    # feed = File.read(File.expand_path("~/.scripts/videos.xml"))
    feed = feed.split("<entry>")
    data = {}
    feed[0].lines do |line|
      @tag_regex.match(line) { |match| data[match[:tag]] = match[:value] }
    end
    chan = @channel_class.new(
      id: data["yt:channelId"],
      name: data["name"],
      cache_file: @cache_file
    )
    video_list = feed.drop(1).map { |entry| video(entry, chan) }
    chan.video_list = video_list.reverse
    chan
  end

  private

  def video(info, channel)
    data = {}
    info.lines do |line|
      @tag_regex.match(line) { |match| data[match[:tag]] = match[:value] }
    end
    published = Time.parse(data["published"])
    @video_class.new(info: data, channel: channel, dl_path: @dl_path)
  end
end

class Channel
  attr_reader :name, :id
  attr_accessor :video_list

  def initialize(id:, name:, cache_file:)
    @id = id
    @name = name
    @video_list = []
    @cache_file = cache_file
  end

  def sync_time=(time)
    cache = File.read(@cache_file)
    cache = JSON.parse(cache)
    cache[@name] = time
    file = File.open(@cache_file, "w")
    JSON.dump(cache, file)
    file.close
  end

  def sync_time
    time = File.read(@cache_file)
    time = JSON.parse(time)[@name]
    Time.parse(time || "2018-03-01")
  end

  def new_videos
    @video_list.select(&:new?)
  end
end

class Video
  attr_reader :id, :published, :title, :description

  def initialize(info:, channel:, dl_path:)
    @id = info["yt:videoId"]
    @title = info["title"]
    @description = info["description"]
    @published = Time.parse(info["published"])
    @channel = channel
    @dl_path = dl_path
  end

  def new?
    @channel.sync_time < @published
    # @published > Time.parse("2018-03-01")
  end

  def download
    Dir.chdir(File.expand_path(@dl_path)) { system("youtube-dl #{@id}") }
    @channel.sync_time = @published
    # puts "fake downloading: #{@title}"
  end
end

Main.new.run
