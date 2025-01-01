extends Command

func run_command(args: Array[String]) -> String:
	# Check how many arguments we have
	if len(args) > 0: 
		# Check if this is a valid command
		if ConsoleManager.command_dict.has(args[0]):
			# If so, return it's help text
			var command: Command = ConsoleManager.command_dict[args[0]]
			return "%s: %s\n" % [command.command, command.help_text]
		else:
			# Otherwise tell the user it is not a valid command
			return "Unknown command `%s`, cannot help." % args[0]

	# Otherwise, print the normal help command
	# Make a string to return
	var return_string = "Type 'help' to see this list.\n\n"
	# Grab our command dictionary
	for key in ConsoleManager.command_dict:
		var value: Command = ConsoleManager.command_dict[key] 
		return_string += "[%s] %s - %s\n" % [value.group, key, value.help_text_short]
	# Add ending message
	return_string += "\nType `help [command]` for more information about a specific command.\n"
	# Return the string
	return return_string
