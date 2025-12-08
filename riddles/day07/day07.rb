require_relative "../riddle"

class Day07 < Riddle
    def initialize
        super 7
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 21)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 40)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            map = readInputFile(filename).split(/\n/)

            beams = Set[map[0].index('S')]
            splits = 0

            (1...map.length).each do |y|
                newBeams = Set[]

                beams.each do |beam|
                    if map[y][beam] == '^' then
                        newBeams.add(beam-1)
                        newBeams.add(beam+1)
                        splits += 1
                    else
                        newBeams.add(beam)
                    end
                end

                beams = newBeams
            end

            return splits
        end

        def calculateSecond(filename)
            map = readInputFile(filename).split(/\n/)

            beams = Set[map[0].index('S')]
            counts = Array.new(map[0].length, 0)
            counts[beams.first] = 1

            (1...map.length).each do |y|
                newBeams = Set[]
                newCounts = Array.new(map[0].length, 0)

                beams.each do |beam|
                    if map[y][beam] == '^' then
                        newBeams.add(beam-1)
                        newBeams.add(beam+1)
                        newCounts[beam-1] += counts[beam]
                        newCounts[beam+1] += counts[beam]
                    else
                        newBeams.add(beam)
                        newCounts[beam] += counts[beam]
                    end
                end

                beams = newBeams
                counts = newCounts
            end

            return counts.sum()
        end
end
