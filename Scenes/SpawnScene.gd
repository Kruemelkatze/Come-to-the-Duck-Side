extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var DuckScene
var duck_textures
# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	randomize()
	_preload_textures()
	$DuckSpawnTimer.start()
	#_spawn_ducks(10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _preload_textures():
  duck_textures = [ preload("res://Art/placeholder_duck_blue.png"), preload("res://Art/placeholder_duck.png")]
  

func _on_DuckSpawnTimer_timeout():
	#pass # Replace with function body.
	
    # Create a Mob instance and add it to the scene.
	var rand_text_index = randi() % duck_textures.size()
	var texture =duck_textures[rand_text_index]
	#var duck = DuckScene.instance(texture)
	#duck.
	var duck = DuckScene.instance()
	#
  #$Sprite.texture = 
	add_child(duck)
	
	#var start_pos=  Vector2(get_viewport().size.x,get_viewport().size.y/2)
	#var start= Vector2(0,0)
 	#mob.set_position(0,0)
	#duck.rotation = 90
    # Set the velocity (speed & direction).
  