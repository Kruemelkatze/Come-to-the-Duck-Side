extends Node

export (PackedScene) var Duck


var duck_index=0 #character index in sequence
var duck_sequence
var paths

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	file.open("res://Scenes/Levels/Level1.json", file.READ)
	duck_sequence = parse_json(file.get_as_text())
	paths = [$DuckPath]
	$SpawnTimer.start()

func _process(delta):
	var ducks = []
	for path in paths:
		ducks += path.get_children()
	for duck in ducks:
		var current_offset = duck.get_offset()
		duck.set_offset(current_offset + delta*duck.speed)

func _on_SpawnTimer_timeout():
	var duck = Duck.instance()
	var duck_config = duck_sequence[duck_index]
	duck.speed = duck_config["speed"]
	duck.set_color(duck_config["color"])
	paths[duck_config["path"]].add_child(duck)
	
	duck_index += 1
	$SpawnTimer.stop()
	if duck_index < len(duck_sequence):
		$SpawnTimer.start(duck_config["break_after"])
