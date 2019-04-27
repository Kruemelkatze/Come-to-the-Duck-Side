extends PathFollow2D

export var speed = 100
var color
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_color(c):
	color = c
	$DuckSprite.modulate = get_color_by_name(c)
	
func get_color_by_name(key):
	if key=='blue':
		return Color("#2b80b9")
	elif key=='red':
		return Color("#e74b3c")
	elif key=='yellow':
		return Color("#f2c311")
	elif key=='cyan':
		return Color("#1cbb9b")
	elif key=='orange':
		return Color("#ED8727")
	elif key=='purple':
		return Color("#89667B")
	elif key=='green':
		return Color("#87BF56")
	else:
		return Color(0,0,0)
