extends Command

func run_command(args: Array[String]) -> String:
	# Clear the output of the console
	ConsoleManager.dev_console.output_text.text = ""
	# Return an empty string
	return ""
