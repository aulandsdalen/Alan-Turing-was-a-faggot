class TMInterpreter
	@@commandsTape = []
	@@memoryTape = []


	def printCommands
		puts commandsTape
	end

	def printMem
		puts memoryTape
	end

	def printAll
		# join them perhaps? 
	end

	def run
	end

	private 

	def parseSourceFile(file)
	end

	def executeCommand(position)
		command = @@commandsTape[position]
		case command
		when 'movr'
			executeCommand((position+1))
		when 'movl'
			executeCommand((position-1))
		when 'inc'
			@@memoryTape[position] += 1
		when 'dec'
			@@memoryTape[position] -= 1
		when 'printb'
			puts @@memoryTape[position]
		when 'getb'
			tmp = gets
			@@memoryTape[position] = tmp[0].to_i
		when 'jz'
			# do something ok?
		when 'endz'
			# loops are to be implemented later 
		else 
			raise NoMethodError, "don't know how to interpret #{command}"
		end
	end
end