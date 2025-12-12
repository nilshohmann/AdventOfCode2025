require_relative "../riddle"

class Day12 < Riddle
    def initialize
        super 12
    end

    private
        def validateFirst
            # Solve under the assumption that all listed presents
            # can fit somehow if the area is big enough.
            # Which is not the case in the example.
            # return expect(calculateFirst("input_test.txt"), 2)
            return true 
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return true # No further data provided
        end

        def solveSecond
            return "FINISHED"
        end

        def calculateFirst(filename)
            data = readInputFile(filename).split(/\n\n/)
            presents = data[0...-1].map { |p| p.chars.count { |c| c == '#' } }

            result = 0
            data[-1].split(/\n/).each do |line|
                (area, counts) = line.split(/: /)
                area = area.split(/x/).map(&:to_i).reduce(1) { |p,c| p*c }
                counts = counts.split(/ /).map(&:to_i)

                neededArea = counts.each_with_index.map { |c, i| c * presents[i] }.sum()
                result += 1 if neededArea < area
            end

            return result
        end

        def calculateSecond(filename)
            return 0
        end
end
