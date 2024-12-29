# GodotDevConsole
A Simple Developer Console you can open with Shift + ` and run commands.

## Installation/Setup

### 1. Adding the Plugin
Add `addons/dev_console` to your addons folder, and then activate it in `Project->Project Settings->Plugins.  

### 2. Autoloads

The Global Autoload ConsoleManager.tscn should be enabled when the plugin is activated but confirm that it is in `Project->Project Settings->Globals`.

As long as the autoload is enabled it should work as you set up an input action.

### 3. Inputs

Lastly, make sure you bind an input action in `Project->Project Settings->Input Map' for `console`. I recommend Shift + `.

Now you should be able to launch any scene and be able to access the console using the bind you set.

## Built-In Commands

help - Prints list of commands and functions.
echo - Repeats <arg> text.
clear - Clears the console's output.
exit - Closes the console.
quit - Closes the application.

## Adding Commands

you can add a command by adding another node under the `Commands` node in ConsoleManager.tscn.
It will need a script attached that inherits from command.gd. You'll need to fill out the fields for the command's
1. Command (what the user will type to run the command)
2. Help Text (what will run when the user types `help [command]`)
3. Short Help Text (what gets displayed in the list of commands when the user runs `help`)

Command nodes get added to the command dictionary on ready. I'd recommend saving each command node to a scene file so that you can add/remove them at will.

## Signals

There is only 1 signal `on_console_close`, which gets emitted when the console is closed.

## Prompt

The only field on the ConsoleManager is `show_prompt`: a toggle to enable or disable the open/close console input prompt.
