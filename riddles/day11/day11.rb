require_relative "../riddle"

class Day11 < Riddle
    def initialize
        super 11
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test_1.txt"), 5)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test_2.txt"), 2)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            $connections = readConnections(filename)
            $paths = {}

            return countPaths('you', 'out')
        end

        def calculateSecond(filename)
            $connections = readConnections(filename)
            $paths = {}

            count = countPaths('svr', 'fft') * countPaths('fft', 'dac') * countPaths('dac', 'out')
            count += countPaths('svr', 'dac') * countPaths('dac', 'fft') * countPaths('fft', 'out')

            return count
        end

        def readConnections(filename)
            connections = {}

            readInputFile(filename).split(/\n/).each do |line|
                (node, targets) = line.split(/: /)
                connections[node] = targets.split(/ /)
            end

            return connections
        end

        def countPaths(start, target)
            if $paths.include? [start, target] then
                return $paths[[start, target]]
            end

            if start == target then
                c = 1
                $paths[[start, target]] = c
                return c
            end

            if start == 'out' then
                $paths[[start, target]] = 0
                return 0
            end

            c = $connections[start].reduce(0) { |p,n| p + countPaths(n, target) }
            $paths[[start, target]] = c
            return c
        end
end
