require_relative "../riddle"

class Day08 < Riddle
    def initialize
        super 8
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt", 10), 40)
        end

        def solveFirst
            calculateFirst("input.txt", 1000)
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 25272)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename, count)
            junctions = readJunctions(filename)
            distances = buildDistances(junctions)

            connected = {}
            circuits = {}
            for i in 0...junctions.length do
                connected[junctions[i]] = i
                circuits[i] = [junctions[i]]
            end

            count.times do
                a, b, d = distances.pop()
                ca, cb = connected[a], connected[b]

                next if ca == cb

                for j in circuits[cb] do
                    connected[j] = ca
                end
                circuits[ca] = circuits[ca] + circuits[cb]
                circuits.delete(cb)
            end

            return circuits.values.map(&:length).sort!.reverse![0...3].reduce(&:*)
        end

        def calculateSecond(filename)
            junctions = readJunctions(filename)
            distances = buildDistances(junctions)

            connected = {}
            circuits = {}
            for i in 0...junctions.length do
                connected[junctions[i]] = i
                circuits[i] = [junctions[i]]
            end

            loop do
                a, b, d = distances.pop()
                ca, cb = connected[a], connected[b]

                next if ca == cb

                for j in circuits[cb] do
                    connected[j] = ca
                end
                circuits[ca] = circuits[ca] + circuits[cb]
                circuits.delete(cb)

                return(a[0] * b[0]) if circuits.length == 1
            end

            return 0
        end

        def readJunctions(filename)
            return readInputFile(filename).split(/\n/).map { |v| v.split(/,/).map(&:to_i) }
        end

        def buildDistances(junctions)
            distances = []
            (junctions.length-1).times do |a|
                for b in (a+1)...junctions.length do
                    distances.append([junctions[a], junctions[b], distance(junctions[a], junctions[b])])
                end
            end
            distances.sort! { |a,b| b[2] <=> a[2] }
            return distances
        end

        def distance(a, b)
            r = 0
            for i in 0..2
                d = (a[i] - b[i])
                r += d*d
            end
            return Math.sqrt(r)
        end
end
