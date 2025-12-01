require_relative "../riddle"

class Day01 < Riddle
    def initialize
        super 1
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 3)
        end

        def solveFirst
            calculateFirst "input.txt"
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 6)
        end

        def solveSecond
            calculateSecond "input.txt"
        end

        def calculateFirst(filename)
            result = 0

            dial = 50
            readInputFile(filename).lines.each do |line|
                dial = (dial + (line[0] == 'R' ? 1 : -1) * line[1,line.length].to_i) % 100
                result += 1 if dial == 0
            end

            return result
        end

        def calculateSecond(filename)
            result = 0

            dial = 50
            readInputFile(filename).lines.each do |line|
                offset = (line[0] == 'R' ? 1 : -1)
                amount = line[1,line.length].to_i
                result += amount / 100 # count full rotations
                (amount % 100).times do # apply the rest
                    dial = (dial + offset) % 100
                    result += 1 if dial == 0
                end
            end

            return result
        end
end
