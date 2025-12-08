require_relative "../riddle"

class Day06 < Riddle
    def initialize
        super 6
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 4277556)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 3263827)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            problems = readInputFile(filename).split(/\n/)
            problems = problems.map do |p|
              p.strip().split(/ +/)
            end

            operations = problems.pop()

            result = 0
            operations.length.times do |i|
                result += problems.length.times
                    .map { |j| problems[j][i].to_i }
                    .reduce(operations[i] == '*' ? :* : :+)
            end

            return result
        end

        def calculateSecond(filename)
            problems = readInputFile(filename).split(/\n/)

            result = 0

            operation = '+'
            values = []

            problems[0].length.times do |i|
                operation = problems[-1][i] if problems[-1][i] != ' '
                v = (problems.length - 1).times.map { |j| problems[j][i] }.filter { |s| s != ' ' }
                if v.empty? then
                    result += values.reduce(operation == '*' ? :* : :+)
                    values = []
                else
                    values.append(v.join('').to_i)
                end
            end

            result += values.reduce(operation == '*' ? :* : :+)

            return result
        end
end
