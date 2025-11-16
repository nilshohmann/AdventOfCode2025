#!/usr/bin/ruby

require "readline"
require_relative "riddles/day01/day01"
require_relative "riddles/day02/day02"
require_relative "riddles/day03/day03"
require_relative "riddles/day04/day04"
require_relative "riddles/day05/day05"
require_relative "riddles/day06/day06"
require_relative "riddles/day07/day07"
require_relative "riddles/day08/day08"
require_relative "riddles/day09/day09"
require_relative "riddles/day10/day10"
require_relative "riddles/day11/day11"
require_relative "riddles/day12/day12"
require_relative "riddles/day13/day13"
require_relative "riddles/day14/day14"
require_relative "riddles/day15/day15"
require_relative "riddles/day16/day16"
require_relative "riddles/day17/day17"
require_relative "riddles/day18/day18"
require_relative "riddles/day19/day19"
require_relative "riddles/day20/day20"
require_relative "riddles/day21/day21"
require_relative "riddles/day22/day22"
require_relative "riddles/day23/day23"
require_relative "riddles/day24/day24"
require_relative "riddles/day25/day25"

riddles = [
    Day01,
    Day02,
    Day03,
    Day04,
    Day05,
    Day06,
    Day07,
    Day08,
    Day09,
    Day10,
    Day11,
    Day12,
    Day13,
    Day14,
    Day15,
    Day16,
    Day17,
    Day18,
    Day19,
    Day20,
    Day21,
    Day22,
    Day23,
    Day24,
    Day25
]

day = ARGV.length >= 1 ? ARGV[0].to_i : 0
while day < 1 || day > riddles.length
    s = Readline.readline("Which day do you want to solve [1-25]? ", true)
    day = s.to_i
end

puts "Solving day #{day}!"
riddle = riddles[day - 1].new
riddle.solve
