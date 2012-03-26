require_relative "../lib/rbtree_map"

file = ARGV.shift or raise

def benchmark(&block)
  begin
    start = Time.now
    yield
    finished = Time.now
  ensure
    puts "$B7P2a;~4V(B #{(finished - start) * 1000} [msec]"
  end
end

print "$BF0:n3NG'(B..."
map = RBTreeMap.newInstance
File.open(file).each_line do |line|
  key, value, height = line.chomp.split(',', 3)
  map.put(key, value)
end
File.open(file).each_line do |line|
  key, value, _ = line.split(',', 3)
  if map.get(key) != value
    raise "$BCM$NIT0lCW(B #{map.get(key)} != #{value} at line #{line}"
  end
end
puts "OK"

puts "$B%Y%s%A%^!<%/(B..."
5.times do |idx|
  print "$B%Y%s%A%^!<%/(B #{idx + 1} $B2sL\(B: "
  benchmark do
    map = RBTreeMap.newInstance
    File.open(file).each_line do |line|
      key, value, height = line.chomp.split(',', 3)
      map.put(key, value)
    end
    File.open(file).each_line do |line|
      key, value, _ = line.split(',', 3)
      if map.get(key) != value
        puts "wrong value! #{map.get(key)} != #{value}"
      end
    end
  end
end
