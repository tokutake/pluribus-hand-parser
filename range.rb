#!/usr/bin/env ruby

require 'set'

class Hole
  attr_accessor :suit, :ranks 

  def initialize(hole)
    @suit = hole[1] == hole[3]

    @ranks = Set[hole[0], hole[2]]
  end

  def ==(o)
    o.class == self.class && o.suit == @suit && o.ranks == @ranks 
  end

  def ===(o)
    o.class == self.class && o.suit == @suit && o.ranks == @ranks 
  end
end

range_holes = {}
player_name = 'MrPink'
STDIN.read.split("\n").each do |a|
  line, file, state, num, action, hole, pl, player = a.split(':')
  if pl && player
    pls = pl.split('|')
    holes = hole.split(/\||\//)
    players = player.split('|')
#    next unless players.include? player_name
#    index = players.index(player_name)
    index = 5
    pl = pls[index].to_i
    hole = Hole.new(holes[index])
    if pl != 0
      if !range_holes.has_key? hole
        range_holes[hole] = 0
      end
      range_holes[hole] += (pl.to_i / 100).round
    end
  end
end

puts 'PLuribus UTG Open'
puts 'OFFSUIT\SUIT'
ranks = 'AKQJT98765432'
print '   '
ranks.each_char do |c|
  print c + '   '
end

puts

i = 0
show_pl = true
ranks.each_char do |column|
  j = 0
  print column + ' '
  ranks.each_char do |row|
    suit = i < j
    hole = Hole.new('AsAc')
    hole.suit = suit
    hole.ranks = Set[column, row]
    key = range_holes.keys.find { |key| key == hole }
    if key
      if show_pl
        print '%3d ' % range_holes[key]
      else
        print column + row
        if column == row
          print ' ' 
        elsif suit
          print 's'
        else
          print 'o'
        end
        print ' ' 
      end
    else
      print '    '
    end
    j += 1
  end
  puts
  i += 1
end

