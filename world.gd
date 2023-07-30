extends Node

@export var next_level_scene : PackedScene
@onready var level_time_label = $LevelTimeCanvasLayer/CenterContainer/LevelTimeLabel
@onready var victory_scene = $CanvasLayer/VictoryScene

var start_time
var level_time

# Called when the node enters the scene tree for the first time.
func _ready():
	victory_scene.visible = false
	get_tree().paused = false
	LevelCompleteScene.show_level_complete(false)
	start_time = Time.get_ticks_msec()
	level_time = Time.get_ticks_msec() - start_time
	LevelCompleteScene.level_complete.connect(show_level_completed)
	LevelCompleteScene.retry.connect(retry_level)
	LevelCompleteScene.next_level.connect(go_to_next_level)
#	polygon_2d.polygon = collision_polygon_2d.polygon

func _process(delta):
	level_time = Time.get_ticks_msec() - start_time
	level_time_label.text = str(level_time / 1000.0)

func show_level_completed():
	get_tree().paused = true
	if (next_level_scene != null):
		LevelCompleteScene.show_level_complete(true)
	else :
		victory_scene.back_to_main_menu_button.grab_focus()
		victory_scene.visible = true
	
	

func retry_level():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)
	
func go_to_next_level():
	if(next_level_scene != null):
		get_tree().change_scene_to_packed(next_level_scene)
