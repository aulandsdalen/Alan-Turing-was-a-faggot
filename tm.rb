class TMInterpreter
	@@commandsTape = []
	@@memoryTape = []
	@@operationsExecuted

	def initialize(file)
		@@operationsExecuted = 0
		@@dataPointer = 0
		@@instructionPointer = 0
		_length = parseSourceFile(file)
		# initialize memory tape with cmdtape size
		_length.times do
			@@memoryTape.push(0)
		end
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
		puts "DP: #{@@dataPointer}, IP: #{@@instructionPointer}"
	end

	def run
		executeCommand
		puts "-- finished --"
		printExecStats
	end

	private 

	@@dataPointer
	@@instructionPointer

	def parseSourceFile(file)
		_tmp = IO.readlines(file)
		_tmp.each do |x| 
			x.chomp! # get rid of newlines
		end
		@@commandsTape = _tmp.reverse # since we're using array as a stack, we'll need to reverse it
		@@commandsTape.length
	end

	def executeCommand
		unless !(_command = @@commandsTape.pop)
			#_command = @@commandsTape.pop
			puts "executing #{_command}, IP: #{@@instructionPointer}, DP: #{@@dataPointer}"
			@@operationsExecuted += 1
			case _command
			when 'movr'
				@@dataPointer += 1
				@@instructionPointer += 1
				executeCommand
			when 'movl'
				@@dataPointer -= 1
				@@instructionPointer += 1
				executeCommand
			when 'inc'
				@@memoryTape[@@dataPointer] += 1
				@@instructionPointer += 1
				executeCommand
			when 'dec'
				@@memoryTape[@@dataPointer] -= 1
				@@instructionPointer += 1
				executeCommand
			when 'printb'
				puts "#{@@memoryTape[@@dataPointer]} at DP: #{@@dataPointer}"
				@@instructionPointer += 1
				executeCommand
			when 'getb'
				tmp = gets
				@@memoryTape[position] = tmp[0].to_i
			when 'jnz' # jump over the endz statement if DP points at non-zero value
				if @@memoryTape[position] != 0
					# seek until encounter 'endz' and call executeCommand w/that position
				else
					executeCommand((position+1))
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