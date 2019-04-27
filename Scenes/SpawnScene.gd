extends Node2D


export (PackedScene) var DuckScene
var duck_textures
var sequence="WWBBWW"
var index=0 #character index in sequence
var sequence_index=0
var pause_index=-1
var spawn_time=0.5
var json
var pause = false  # Flag for enable/disable spawn or pause

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass
	#randomize()
	_preload_textures()
	var file = File.new()
	file.open("res://Levels/spawn.json", file.READ)
	
	json = parse_json(file.get_as_text())
	sequence = json["sequence"][sequence_index]
	#TODO: Set spawn_time based on speed
	$DuckSpawnSequenceTimer.start(spawn_time)
	
	

func _preload_textures():
  duck_textures = [ preload("res://Art/placeholder_duck_blue.png"), preload("res://Art/placeholder_duck.png")]
 
func get_texture(key):
	if key=='W':
		return 1
	elif key=='B':
		return 0

func _on_DuckSpawnTimer_timeout():
	
	
	#sequence="WWBBWW"
	if !pause:
		var duck = DuckScene.instance()
		var sequence_char =sequence[index]
		duck.set_texture(duck_textures[get_texture(sequence_char)])
		duck.set_speed(json["speed"][sequence_index])
		add_child(duck)
		index+=1
		if index==len(sequence):
			$DuckSpawnSequenceTimer.stop()
			pause_index+=1
			if pause_index!=len(json["pause"]):
				$DuckSpawnSequenceTimer.start(json["pause"][pause_index])
				pause=true
	elif pause:
		$DuckSpawnSequenceTimer.stop()
		pause=false
		sequence_index+=1
		if sequence_index==len(json["sequence"]):
			$DuckSpawnSequenceTimer.stop()
		print(sequence_index)
		sequence = json["sequence"][sequence_index]
		index=0
		$DuckSpawnSequenceTimer.start(spawn_time)
	
	
  