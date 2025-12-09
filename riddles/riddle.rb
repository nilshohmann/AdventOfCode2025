class Riddle 
    def initialize day
        @day = day
    end

    def solve
        r1 = Result.new("INVALID", 0)
        if validateFirst
            r1 = measure method(:solveFirst)
        end

        r2 = Result.new("INVALID", 0)
        if validateSecond
            r2 = measure method(:solveSecond)
        end

        puts "# Results"
        puts
        puts "| Part | Result | Time |"
		puts "| --- | --- | --- |"
        puts "| 1 | #{r1.result} | #{formatDuration r1.elapsed} |"
        puts "| 2 | #{r2.result} | #{formatDuration r2.elapsed} |"
    end

    private
        def validateFirst
            return false
        end

        def solveFirst
            raise "solveFirst not implemented"
        end

        def validateSecond
            return false
        end

        def solveSecond
            raise "solveSecond not implemented"
        end

        def readInputFile(filename)
            return File.read("#{Dir.pwd}/riddles/day%02d/#{filename}" % @day)
        end

        def expect(result, expected)
            if result == expected
                return true
            end

            if result.instance_of?(String)
                puts "Expected '#{expected}' but got '#{result}'"
            else
                puts "Expected #{expected} but got #{result}"
            end

            return false
        end

        def measure(action)
            start = Time.now
            solution = action.call
            return Result.new(solution, Time.now - start)
        end

        def formatDuration(duration)
            if duration < 1
                return "#{(duration * 1000 * 100).round / 100.0}ms"
            else
                return "#{(duration * 100).round / 100.0}s"
            end
        end
end

Result = Struct.new(:result, :elapsed)
