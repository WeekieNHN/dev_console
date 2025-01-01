# GodotDevConsole
A Simple Developer Console you can open and run commands.

## Installation/Setup

### 1. Adding the Plugin
Add `addons/dev_console` to your addons folder, and then activate it in `Project->Project Settings->Plugins`.  

### 2. Autoloads

The Global Autoload ConsoleManager.tscn should be enabled when the plugin is activated but confirm that it is in `Project->Project Settings->Globals`.

As long as the autoload is enabled it should work!

## Built-In (Base) Commands

help - Prints list of commands and functions.
echo - Repeats <arg> text.
clear - Clears the console's output.
exit - Closes the console.
quit - Closes the application.

## Adding Commands

### Adding an Aggregator

To make aggreagation of commands easier, I've added a `CommandAggregator` class. To make a command aggregator: add `command_aggregator.gd` to a node. There is an example with base commands in `ConsoleManager.tscn`.

I'd recommend make your command aggregator a child of a singleton (autoload) so that it will always exist. In my packages, I add an aggegator under each singleton which holds the commands related to that singleton. That way everything stays "modular".

### Adding Commands to an Aggregator

you can add a command by adding another node as a child of a command aggegator.
The command node will need a script attached that inherits from command.gd. You'll need to fill out the fields for the command's
1. Command (what the user will type to run the command)
2. Group (To help differentiate commands)
3. Help Text (what will run when the user types `help [command]`)
4. Short Help Text (what gets displayed in the list of commands when the user runs `help`)

Command nodes get added to the command dictionary-- by the aggregator-- on ready. I'd also recommend saving each command node to a scene file so that you can add/remove them at will.

## Signals

### `on_console_open`

Emitted when the console is opened. Connect to this to pause input for the player when the console is opened.

### `on_console_close`

Emitted when the console is closed. Connect to this to grab focus, or unpause input when the console is closed

## Prompt

The only field on the ConsoleManager is `show_prompt`: a toggle to enable or disable the open/close console input prompt.
