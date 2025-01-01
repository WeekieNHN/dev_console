extends Node

# Use this to pause input when the console is opened
signal on_console_open
# Use this to grab focus when the console is closed
signal on_console_close

@export var show_prompt: bool = true

@onready var prompt_layer: Control = $PromptLayer
@onready var console_layer: CanvasLayer = $ConsoleCanvasLayer
@onready var dev_console: DevConsole = %DevConsole

var command_dict = {}

var command_history: Array[String] = [] # Hold previous commands
var command_history_index = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hide the console
	console_layer.visible = false
	# Show/hide the prompt
	prompt_layer.visible = show_prompt
	
	# Add console_inputs
	if !InputMap.has_action("console_open"):
		InputMap.add_action("console_open")
		var console_open_key: InputEventKey = InputEventKey.new()
		console_open_key.physical_keycode = KEY_QUOTELEFT
		InputMap.action_add_event("console_open", console_open_key)
	
	# Add console_inputs
	if !InputMap.has_action("console_up"):
		InputMap.add_action("console_up")
		var console_up_key: InputEventKey = InputEventKey.new()
		console_up_key.physical_keycode = KEY_UP
		InputMap.action_add_event("console_up", console_up_key)
	
	# Add console_inputs
	if !InputMap.has_action("console_down"):
		InputMap.add_action("console_down")
		var console_down_key: InputEventKey = InputEventKey.new()
		console_down_key.physical_keycode = KEY_DOWN
		InputMap.action_add_event("console_down", console_down_key)
	
	# Set prompt text with console prompt
	$PromptLayer/Label.text = "Press %s to open/close the console." % InputMap.action_get_events("console_open")[0].as_text()

func add_command(cmd_name: String, cmd: Command) -> void:
	# Check for duplicates
	if command_dict.has(cmd_name):
		print("Command Name %s already has a command associated with it. Skipping." % cmd_name)
		return
	# Add command to dict
	command_dict[cmd_name] = cmd

func _input(_event):
	# Skip if no console open action
	if !InputMap.has_action("console_open"): return
	# Check if console input was pressed, if so, toggle
	if Input.is_action_just_pressed("console_open"):
		toggle_visible()
	
	# If Console open, Check if up/down inputs pressed
	if console_layer.visible:
		if Input.is_action_just_pressed("console_up"):
			# Check if we can move up the history
			if command_history_index < len(command_history) - 1:
				# Increment command history index
				command_history_index += 1
				# Set the command text entry box text
				dev_console.text_entry.text = command_history[command_history_index]
		if Input.is_action_just_pressed("console_down"):
			# Check if we can move down the history
			if command_history_index > -1:
				# Dencrement command history index
				command_history_index -= 1
				if command_history_index == -1:
					dev_console.text_entry.text = ""
				else:
					dev_console.text_entry.text = command_history[command_history_index]
			

func toggle_visible() -> void:
	# Toggle the visibility
	console_layer.visible = !console_layer.visible
	# Emit closed signal
	if console_layer.visible: on_console_open.emit()
	else: on_console_close.emit()

func run_command(raw_command: String) -> void:
	# Insert command in history (slot 0)
	command_history.insert(0, raw_command)
	# Reset the history index so we always start at the newest command
	command_history_index = -1
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
