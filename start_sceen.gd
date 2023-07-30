extends Control

@export var start_level_scene: PackedScene
@onready var start_button = $CenterContainer/VBoxContainer/StartButton

func _ready():
	start_button.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(start_level_scene)

func _on_quit_button_pressed():
	get_tree().quit()
