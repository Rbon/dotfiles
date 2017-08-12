#!/usr/bin/ruby

if ARGV.include?("-s")
  subs = ARGV.slice!(ARGV.index("-s") + 1)
  ARGV.slice!(ARGV.index("-s"))
end

if ARGV.include?("-d")
  ARGV.slice!(ARGV.index("-d"))
  
  if subs
    ARGV[0] = ARGV[0].tr(subs, "01")
  end
  
  ARGV[0] = [ARGV[0]].pack("B*")
  
else
  ARGV[0] = ARGV[0].unpack("B*")[0]
  
  if subs
    ARGV[0] = ARGV[0].tr("01", subs)
  end
end

puts ARGV