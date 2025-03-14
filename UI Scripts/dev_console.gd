class_name DevConsole extends Control

@onready var text_entry: LineEdit = %TextEntry
@onready var submit_button: Button = %SubmitButton
@onready var output_text: RichTextLabel = %OutputText
@onready var close_button: Button = %CloseButton

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect Submit signals
	text_entry.text_submitted.connect(submit_command_text_entry)
	submit_button.pressed.connect(submit_command_button)
	# Connect close signal
	close_button.pressed.connect(ConsoleManager.toggle_visible)
	# Clear our output text
	output_text.text = ""

func submit_command_button() -> void:
	# Save text
	var raw_command = text_entry.text
	# Only run commands, check for empty string
	if raw_command == "": return
	# Clear the text entry
	text_entry.text = ""
	# Send command to Singleton
	ConsoleManager.run_command(raw_command)

func submit_command_text_entry(raw_command: String) -> void:
	# Only run commands, check for empty string
	if raw_command == "": return
	# Clear the text entry
	text_entry.text = ""
	# Send command to Singleton
	ConsoleManager.run_command(raw_command)

func console_print_log(text: String) -> void:
	# Add the text to output
	output_text.text += text
