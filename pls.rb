#!/usr/bin/env ruby

sums = {}
STDIN.read.split("\n").each do |a|
  line, file, state, num, action, hole, pl, player = a.split(':')
  if pl && player
    pls = pl.split('|')
    players = player.split('|')
    index = players.index('Pluribus')
    players.each_with_index do |player, index|
      sums[player] = 0 if sums[player].nil?
      sums[player] += pls[index].to_i
    end
  end
end

p sums
