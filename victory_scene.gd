extends CanvasLayer

@onready var back_to_main_menu_button = $CenterContainer/VBoxContainer/HBoxContainer/BackToMainMenuButton

func _on_back_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://start_sceen.tscn")
