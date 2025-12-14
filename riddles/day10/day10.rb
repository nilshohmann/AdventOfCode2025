require_relative "../riddle"

require 'set'

Machine = Struct.new(:lights, :buttons, :joltages)

class Day10 < Riddle
    def initialize
        super 10
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 7)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 33)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            machines = readMachines(filename)

            result = 0

            machines.each do |m|
                target = m.lights.split(//).reduce(0) { |p,c| (p << 1) + (c == '#' ? 1 : 0) }
                buttons = m.buttons.map { |b| m.lights.length.times.reduce(0) { |p,c|
                    (p << 1) + (b.include?(c) ? 1 : 0)
                }}

                checked = Set[]
                states = [[0, 0, Array.new(buttons.length, 0)]] # [count, current light, buttons]
                while !states.empty? do
                    (count, state, pressed) = states.shift

                    break if count > 10

                    if state == target then
                        result += count
                        break
                    end

                    next if checked.include? pressed
                    checked.add(pressed)

                    buttons.each_with_index do |b,i|
                        newPressed = pressed.dup
                        newPressed[i] += 1

                        states.append([count+1, state ^ b, newPressed])
                    end
                end
            end

            return result
        end

        def calculateSecond(filename)
            machines = readMachines(filename)

            result = 0

            machines.each_with_index do |m, i|
                $best = 99999

                findBest(m.joltages, 0, m.buttons)

                result += $best
            end

            return result
        end

        def readMachines(filename)
            return readInputFile(filename).split(/\n/).map do |line|
                values = line.split(/ /)
                Machine.new(
                    values[0][1...-1],
                    values[1...-1].map { |b| b[1...-1].split(/,/).map(&:to_i) },
                    values[-1][1...-1].split(/,/).map(&:to_i)
                )
            end
        end

        def findBest(joltages, count, buttons)
            return if joltages.any?(&:negative?)

            remaining = joltages.max
            if remaining == 0 then
                $best = count if count < $best
                return
            end

            return if count + remaining >= $best

            for i in 0...joltages.length do
                for j in 0...joltages.length do
                    next if joltages[i] <= joltages[j]

                    possible = buttons.filter { |b| b.include?(i) && !b.include?(j) }
                    return if possible.empty?

                    if possible.length == 1 then
                        nextJoltages = joltages.clone
                        possible[0].each { |v| nextJoltages[v] -= 1 }
                        findBest(nextJoltages, count + 1, buttons)
                        return
                    end
                end
            end

            for i in 0...buttons.length do
                nextJoltages = joltages.clone
                buttons[i].each { |v| nextJoltages[v] -= 1 }
                findBest(nextJoltages, count + 1, buttons[i..])
            end
        end
end
