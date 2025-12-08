require_relative "../riddle"

require 'set'

class Day02 < Riddle
    def initialize
        super 2
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 1227775554)
        end

        def solveFirst
            calculateFirst("input.txt")
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 4174379265)
        end

        def solveSecond
            calculateSecond("input.txt")
        end

        def calculateFirst(filename)
            ids = readInputFile(filename).split(/,/).map { |e|
                e.split(/-/).map(&:to_i)
            }

            result = 0
            ids.each do |first, last|
                (first..last).each do |id|
                    if isInvalidFirst(id.to_s) then
                        result += id
                    end
                end
            end

            return result
        end

        def calculateSecond(filename)
            ids = readInputFile(filename).split(/,/).map { |e|
                e.split(/-/).map(&:to_i)
            }

            result = 0
            ids.each do |first, last|
                (first..last).each do |id|
                    if isInvalidSecond(id.to_s) then
                        result += id
                    end
                end
            end

            return result
        end

        def isInvalidFirst(id)
            return id.length % 2 == 0 && id[0, id.length / 2] == id[id.length / 2, id.length]
        end

        def isInvalidSecond(id)
            (1..(id.length / 2)).each do |c|
                if id.length % c == 0 then
                    if (0...id.length).step(c).map { |i| id[i, c] }.to_set.length == 1 then
                        return true
                    end
                end
            end

            return false
        end
end

Ids = Struct.new(:first, :last)
