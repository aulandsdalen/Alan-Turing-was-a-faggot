require './tm.rb'

t = TMInterpreter.new
t.load("test.tm")
t.run
