extends PathFollow2D

signal missed_duck

export var speed = 100
export var color = 'default'

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_color(color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_color(c):
	color = c
	$DuckSprite/ColorSprite.modulate = Globals.get_color_by_name(c)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("missed_duck")
	queue_free()

func kill_me():
	queue_free()
