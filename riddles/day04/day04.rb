require_relative "../riddle"

class Day04 < Riddle
    def initialize
        super 4
    end

    private
        def validateFirst
            return expect(calculateFirst("input_test.txt"), 13)
        end

        def solveFirst
            calculateFirst "input.txt"
        end

        def validateSecond
            return expect(calculateSecond("input_test.txt"), 43)
        end

        def solveSecond
            calculateSecond "input.txt"
        end

        def calculateFirst(filename)
            paperRolls = readPaperRolls(filename)
            return findRemovablePapers(paperRolls).length
        end

        def calculateSecond(filename)
            paperRolls = readPaperRolls(filename)

            result = 0

            loop do
                removable = findRemovablePapers(paperRolls)
                break if removable.empty?

                result += removable.length
                removable.each do |p|
                    paperRolls.delete(p)
                end
            end

            return result
        end

        def readPaperRolls(filename)
            paperRolls = Hash.new(false)
            readInputFile(filename).split(/\n/).each_with_index do |line, y|
                line.split(//).each_with_index do |c, x|
                    paperRolls[x + y * 1i] = true if c == '@'
                end
            end

            return paperRolls
        end

        def findRemovablePapers(paperRolls)
            removable = []
            paperRolls.each_key do |p|
                c = 0
                (-1..1).each do |x|
                    (-1..1).each do |y|
                        c += 1 if paperRolls[p + x + y*1i]
                    end
                end

                removable.append(p) if c <= 4
            end

            return removable
        end
end
