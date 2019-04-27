extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var DuckScene
var duck_textures
var sequence="WWBBWW"
var index=0

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	randomize()
	_preload_textures()
	var file = File.new()
	file.open("res://Levels/spawn.json", file.READ)
	
	var json = parse_json(file.get_as_text())
	sequence = json["sequence"][1]
	print()
	$DuckSpawnSequenceTimer.start()
	
	#_spawn_ducks(10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _preload_textures():
  duck_textures = [ preload("res://Art/placeholder_duck_blue.png"), preload("res://Art/placeholder_duck.png")]
 
func get_texture(key):
	if key=='W':
		return 1
	elif key=='B':
		return 0

func _on_DuckSpawnTimer_timeout():
	
	
	#sequence="WWBBWW"
	var duck = DuckScene.instance()
	var sequence_char =sequence[index]
	duck.set_texture(duck_textures[get_texture(sequence_char)])
	index+=1
	if index==len(sequence):
		$DuckSpawnSequenceTimer.stop()
	add_child(duck)
  