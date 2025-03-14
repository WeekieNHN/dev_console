extends Command

func run_command(args: Array[String]) -> String:
	# quit game
	get_tree().quit()
	# Return an empty string
	return ""
