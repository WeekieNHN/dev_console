class_name Command extends Node

@export var command: String = "help"
@export var group: String = "Base"
@export var help_text: String = ""
@export var help_text_short: String = ""

func run_command(args: Array[String]) -> String:
	return ""
