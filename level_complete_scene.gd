extends CanvasLayer

class_name LevelComplete

signal level_complete
signal retry
signal next_level

@onready var level_complete_container = $LevelCompleteContainer
@onready var color_rect = $ColorRect
@onready var retry_button = $LevelCompleteContainer/VBoxContainer/HBoxContainer/RetryButton
@onready var next_level_button = $LevelCompleteContainer/VBoxContainer/HBoxContainer/NextLevelButton



func _ready():
	show_level_complete(false)

func show_level_complete(value: bool):
	level_complete_container.visible = value
	color_rect.visible = value
	next_level_button.grab_focus()


func _on_retry_button_pressed():
	show_level_complete(false)
	retry.emit()


func _on_next_level_button_pressed():
	next_level.emit()
