extends Node

export (PackedScene) var Duck

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.start()
	randomize()


func _process(delta):
	var ducks = $DuckPath.get_children()
	for duck in ducks:
		var current_offset = duck.get_offset()
		duck.set_offset(current_offset + delta*duck.speed)
	


func _on_SpawnTimer_timeout():
	var duck = Duck.instance()
	duck.speed = 150
	#if randi() % 2 == 0:
	#	duck.get_node("DuckSprite/AnimatedSprite").animation = "blue"
	if randi() % 2 == 0:
		duck.get_node("DuckSprite").modulate = Color(0, 0, 1)
	$DuckPath.add_child(duck)
	
