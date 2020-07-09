extends Node
var start_button
var exit_button

func _ready():
	start_button = get_node("MarginContainer/HBoxContainer/VBoxContainer/StartButton")
	exit_button = get_node("MarginContainer/HBoxContainer/VBoxContainer/ExitButton")
	start_button.grab_focus()

func _process(delta):
	if start_button.is_hovered():
		start_button.grab_focus()
	if exit_button.is_hovered():
		exit_button.grab_focus()

