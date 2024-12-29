extends Node

# Use this to grab focus when the console is closed
signal on_console_close

@export var show_prompt: bool = true
@onready var prompt_layer: Control = $PromptLayer

@onready var console_layer: CanvasLayer = $ConsoleCanvasLayer
@onready var dev_console: DevConsole = %DevConsole
@onready var commands_holder: Node = %Commands

var command_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide the console
	console_layer.visible = false
	# Show/hide the prompt
	prompt_layer.visible = show_prompt
	# Set prompt text
	$PromptLayer/Label.text = "Press %s to open/close the console." % InputMap.action_get_events("console")[0].as_text()
	# Add commands
	for child in commands_holder.get_children():
		if child is Command:
			ConsoleManager.add_command(child.command, child)

func add_command(cmd_name: String, cmd: Command) -> void:
	# Check for duplicates
	if command_dict.has(cmd_name):
		print("Command Name %s already has a command associated with it. Skipping." % cmd_name)
		return
	# Add command to dict
	command_dict[cmd_name] = cmd

func _input(_event):
	# Check if console input was pressed, if so, toggle
	if Input.is_action_just_pressed("console"):
		toggle_visible()

func toggle_visible() -> void:
	# Toggle the visibility
	console_layer.visible = !console_layer.visible
	# Emit closed signal
	if !console_layer.visible: on_console_close.emit()

func run_command(raw_command: String) -> void:
	# Split the command
	var command_split = raw_command.split(' ', false)
	# Identify Command
	if command_dict.has(command_split[0]):
		# Print the command to console to indicate it was submitted
		dev_console.console_print_log("> %s\n" % raw_command)
		# Run the command
		var output_string: String = command_dict[command_split[0]].run_command(command_split.slice(1))
		# Print it's output to dev_console 
		dev_console.console_print_log(output_string)
	# If unidentified, tell the user
	else:
		dev_console.console_print_log("Command `%s` not found\n" % command_split[0])
