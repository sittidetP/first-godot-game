extends Area2D

var collectable_amount = 0



func _on_body_entered(body):
	queue_free()
	collectable_amount = get_tree().get_nodes_in_group("Coins").size()
	
	if(collectable_amount == 1):
		LevelCompleteScene.level_complete.emit()
	

