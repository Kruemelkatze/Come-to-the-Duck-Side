extends Node

export (PackedScene) var Duck


var sequence
var duck_index=0 #character index in sequence
var sequence_index=0
var pause_index=-1
var json
var pause = false  # Flag for enable/disable spawn or pause

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var file = File.new()
	file.open("res://Scenes/Levels/spawn.json", file.READ)
	json = parse_json(file.get_as_text())
	
	sequence = json["sequences"][sequence_index]
	$SpawnTimer.start(sequence["spawn_time"])
	


func _process(delta):
	var ducks = $DuckPath.get_children()
	for duck in ducks:
		var current_offset = duck.get_offset()
		duck.set_offset(current_offset + delta*duck.speed)
		
func get_color(key):
	if key=='Blau':
		return Color(0,0,1)
	elif key=='Rot':
		return Color(1,0,0)


func _on_SpawnTimer_timeout():
	
	
	
	#sequence="WWBBWW"
	if !pause:
		var duck = Duck.instance()
		duck.speed = sequence["speed"]
		var color = get_color(sequence["ducks"][duck_index])
		duck.get_node("DuckSprite").modulate = Color(color.r, color.g, color.b)
		$DuckPath.add_child(duck)
		
		duck_index+=1
		if duck_index==len(sequence["ducks"]):
			$SpawnTimer.stop()
			pause_index+=1
			if pause_index!=len(json["pause"]):
				$SpawnTimer.start(json["pause"][pause_index])
				pause=true
	elif pause:
		$SpawnTimer.stop()
		pause=false
		print(sequence_index)
		sequence_index+=1
		if sequence_index==len(json["sequences"]):
			$SpawnTimer.stop()
		else:
			sequence = json["sequences"][sequence_index]
			duck_index=0
			$SpawnTimer.start(sequence["spawn_time"])
