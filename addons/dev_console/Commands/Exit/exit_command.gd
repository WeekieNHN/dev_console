extends Command

func run_command(args: Array[String]) -> String:
	# Close the console
	ConsoleManager.toggle_visible()
	# Return an empty string
	return "Exited Console.\n"
