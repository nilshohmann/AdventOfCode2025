require_relative "../riddle"

class Day15 < Riddle
    def initialize
        super 15
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 1)
        end

        def solveFirst
            calculateFirst "input.txt"
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 2)
        end

        def solveSecond
            calculateSecond "input.txt"
        end

        def calculateFirst(filename)
            return 0
        end

        def calculateSecond(filename)
            return 0
        end
end
