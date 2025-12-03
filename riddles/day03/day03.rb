require_relative "../riddle"

class Day03 < Riddle
    def initialize
        super 3
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 357)
        end

        def solveFirst
            calculateFirst "input.txt"
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 3121910778619)
        end

        def solveSecond
            calculateSecond "input.txt"
        end

        def calculateFirst(filename)
            result = 0

            readInputFile(filename).split(/\n/).each do |battery|
                first = findMaxIndex(battery[0...-1], 0)
                second = findMaxIndex(battery, first + 1)
                result += (battery[first] + battery[second]).to_i
            end

            return result
        end

        def calculateSecond(filename)
            result = 0

            readInputFile(filename).split(/\n/).each do |battery|
                num = ''

                start = 0
                (0..10).each do |i|
                    pos = findMaxIndex(battery[0...(i-11)], start)
                    num += battery[pos]
                    start = pos + 1
                end

                num += battery[findMaxIndex(battery, start)]
                result += num.to_i
            end

            return result
        end

        def findMaxIndex(battery, start)
            max = start
            ((start+1)...(battery.length)).each do |i|
                max = i if battery[i] > battery[max]
            end
            return max
        end
end
