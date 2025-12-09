require_relative "../riddle"

class Day09 < Riddle
    def initialize
        super 9
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 50)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 24)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            points = readPoints(filename)

            best = 0

            (points.length-1).times do |i|
                for j in i...points.length do
                    a, b = points[i], points[j]
                    area = ((a[0]-b[0]).abs + 1) * ((a[1]-b[1]).abs + 1)
                    best = area if area > best
                end
            end

            return best
        end

        def calculateSecond(filename)
            points = readPoints(filename)

            vertical = []
            horizontal = []

            points.length.times do |i|
                a, b = points[i], points[(i+1)%points.length]
                if a[0] == b[0] then
                    xr = [a[1], b[1]].sort
                    horizontal.push([a[0], xr[0]+1, xr[1]-1])
                else
                    yr = [a[0], b[0]].sort
                    vertical.push([a[1], yr[0]+1, yr[1]-1])
                end
            end

            best = 0

            (points.length-1).times do |i|
                for j in i...points.length do
                    a, b = points[i], points[j]
                    from = [[a[0], b[0]].min + 1, [a[1], b[1]].min + 1]
                    to = [[a[0], b[0]].max - 1, [a[1], b[1]].max - 1]

                    # Valid rectangle but not relevant
                    next if from[0] > to[0] || from[1] > to[1]

                    valid = true

                    for (x, y1, y2) in vertical do
                        if x >= from[1] and x <= to[1] and y1 <= to[0] and y2 >= from[0] then
                            valid = false
                            break
                        end
                    end
                    next if !valid

                    for (y, x1, x2) in horizontal do
                        if y >= from[0] and y <= to[0] and x1 <= to[1] and x2 >= from[1] then
                            valid = false
                            break
                        end
                    end
                    next if !valid

                    area = ((a[0]-b[0]).abs + 1) * ((a[1]-b[1]).abs + 1)
                    best = area if area > best
                end
            end

            return best
        end

        def readPoints(filename)
            readInputFile(filename).split(/\n/).map do |line|
                line.split(/,/).map(&:to_i)
            end
        end
end
