#!/usr/bin/env ruby

require "json"

class Main
  attr_reader :color, :arguments

  def initialize(opts)
    @background = opts["background"]
    @foreground = opts["foreground"]
    # @color1 = opts[":color1"]
    # @font = "-windows-dina-medium-r-*-*-10-*-*-*-*-*-*-*"
    # @mon_w = `xrandr | grep -o -G \"current [0-9]*\" | tail -c 5`.to_i
    # @bar_w = @mon_w - 32
    # @bar_h = 24
    # @bar_x = 16
    # @bar_y = 16
    # @dimensions = "#{@bar_w}x#{@bar_h}+#{@bar_x}+#{@bar_y}"
    # @arguments = "-d -g #{@dimensions} -B \"#{@background}\" -f #{@font} -F \"#{@foreground}\""
  end

  def workspaces(info)
    @i3_info = JSON.parse(info)
    @workspace_list = []
    @i3_info.each do |ws|
      # puts ws.to_s
      @workspace_list.push(Workspace.new(
        name: ws["name"],
        focused: ws["focused"],
        foreground: @foreground,
        background: @background
      ).output)
    end
    @workspace_list.join(" ")
  end

  def clock
    `date '+%H:%M - %A, %B %d - %Y'`
  end

  def run
    system("echo | lemonbar -n bar_invisible -g \"1x40\" -p &")
    exec("while :; do ruby \"#{__FILE__}\" -w; sleep 0.5; done | lemonbar #{@arguments}")
  end
end

class Workspace
  attr_reader :output
  def initialize(opts)
    @name = opts[:name]
    @focused = opts[:focused]
    @fg = opts[:foreground]
    @bg = opts[:background]
    @fg_map = {true => @bg, false => @fg}
    @bg_map = {true => @fg, false => @bg}
    @output = "%{F#{@fg_map[@focused]}}%{B#{@bg_map[@focused]}}" +
      "#{@name}" +
      "%{B#{@bg}}" +
      "%{F#{@fg}}"
  end
end

class Resources
  attr_reader :resources

  def initialize
    @resources = `xrdb -query`.tr("*:", "").split("\n")
    @colors = []
    @resources.each { |line| @colors.push(line.split("\t")) }
    @resources = Hash[@colors]
  end
end

class Screen
  def initialize
  end
end

main = Main.new(
  Resources.new.resources
)

case ARGV[0]
when "-w"
  puts main.workspaces(ARGV[1])
when "-a"
  puts main.arguments
else
  main.run
end

