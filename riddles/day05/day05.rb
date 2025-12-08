require_relative "../riddle"

class Day05 < Riddle
    def initialize
        super 5
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 3)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 14)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            ranges, ids = readInputFile(filename).split(/\n\n/)
            ranges = parseRanges(ranges)

            result = 0
            ids.split(/\n/).map(&:to_i).each do |id|
                result += 1 if ranges.any? { |r| r.member?(id) }
            end

            return result
        end

        def calculateSecond(filename)
            ranges, ids = readInputFile(filename).split(/\n\n/)
            ranges = parseRanges(ranges).sort { |x,y| x.begin <=> y.begin }

            result = 0
            while !ranges.empty? do
                r = ranges.shift

                i = 0
                while i < ranges.length do
                    if ranges[i].begin <= r.end then
                        r = r.begin .. [r.end, ranges[i].end].max
                        ranges.delete_at(i)
                    else
                        i += 1
                    end
                end

                result += r.size()
            end

            return result
        end

        def parseRanges(data)
            data.split(/\n/).map do |line|
                from, to = line.split(/-/)
                from.to_i .. to.to_i
            end
        end
end
