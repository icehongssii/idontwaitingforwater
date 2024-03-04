extends ParallaxLayer

var speed = -50  # The speed of the scrolling

func _ready():
	set_mirroring(Vector2(800, 600))  # Set this to the size of your ground image

func _process(delta):
	var new_offset = get_motion_offset()
	new_offset.x += speed * delta
	set_motion_offset(new_offset)
