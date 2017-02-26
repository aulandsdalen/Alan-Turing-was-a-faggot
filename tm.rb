class TMInterpreter
	@@commandsTape = []
	@@memoryTape = []
	@@operationsExecuted

	def initialize
		@@operationsExecuted = 0
		@@dataPointer = 0
		@@memoryTape.push(0) # initialize w/ 0 at :0
	end

	def load(file)
		_length = parseSourceFile(file)
		puts "got #{_length} commands from #{file}"
	end


	def printCommands
		puts @@commandsTape
	end

	def printMem
		puts @@memoryTape
	end

	def printExecStats
		puts "Executed #{@@operationsExecuted} ops "
		puts "Mem: #{@@memoryTape}"
		puts "Commands: #{@@commandsTape}"
		puts "DP: #{@@dataPointer}"
	end

	def run
		executeCommand
		puts "\n-- finished --\n"
		printExecStats
	end

	private 

	@@dataPointer

	def parseSourceFile(file)
		_tmp = IO.readlines(file)
		_tmp.each do |x| 
			x.chomp! # get rid of newlines
			x.strip! # get rid of whitespaces
		end
		@@commandsTape = _tmp.reverse # since we're using array as a stack, we'll need to reverse it
		@@commandsTape.delete_if {|x| x[0] == "*"} # delete comments from commandsTape, comments are starting with *
		@@commandsTape.length
	end

	def executeCommand
		unless !(_command = @@commandsTape.pop)
			@@operationsExecuted += 1
			case _command
			when 'movr'
				@@dataPointer += 1
				if @@dataPointer == @@memoryTape.length # right overflow
					@@memoryTape.push(0) # insert zero cell on right, DP would be already set to that
					puts "got right OF, inserted new cell at :#{@@dataPointer}"
				end
				executeCommand
			when 'movl'
				@@dataPointer -= 1
				if @@dataPointer < 0
					@@memoryTape.insert(0,0)
					@@dataPointer = 0
					puts "got left OF, inserted new cell at :0 (virtual :-1), DP now :#{@@dataPointer}"
				end
				executeCommand
			when 'inc'
				@@memoryTape[@@dataPointer] += 1
				puts "incremented :#{@@dataPointer}"
				executeCommand
			when 'dec'
				@@memoryTape[@@dataPointer] -= 1
				executeCommand
			when 'printb'
				puts "#{@@memoryTape[@@dataPointer]} at DP: #{@@dataPointer}"
				executeCommand
			when 'printc'
				print "#{@@memoryTape[@@dataPointer].chr}"
				executeCommand
			when 'getb'
				print "input> "
				tmp = gets
				puts "setting :#{@@dataPointer} to #{tmp}"
				@@memoryTape[@@dataPointer] = tmp.to_i
				executeCommand
			when 'getc'
				print "input(char)> "
				tmp = gets
				puts "setting :#{@@dataPointer} to #{tmp.ord}"
				@@memoryTape[@@dataPointer] = tmp.ord
				executeCommand
			when 'jnz' # jump over the endz statement if DP points at non-zero value
				if @@memoryTape[@@dataPointer] != 0
					# seek until encounter 'endz' and call executeCommand w/that position
				else
					@@dataPointer += 1
					executeCommand
				end
			when 'endz'
				# loops are to be implemented later 
			else 
				raise NoMethodError, "don't know how to interpret '#{_command}'"
			end
		else 
			return 0
		end
	end
end