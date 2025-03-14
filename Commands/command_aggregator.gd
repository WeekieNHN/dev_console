class_name CommandAggregator extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add commands
	for child in get_children():
		if child is Command:
			ConsoleManager.add_command(child.command, child)
