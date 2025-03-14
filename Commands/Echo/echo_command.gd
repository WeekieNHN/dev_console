extends Command

func run_command(args: Array[String]) -> String:
	# Make a string to return
	var return_string = ""
	# Grab our command dictionary
	for arg in args:
		return_string += "%s " % arg
	# Add final rewline character
	return_string += "\n"
	# Return the string
	return return_string
