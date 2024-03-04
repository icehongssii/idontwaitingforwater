extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func show_message(text):
	$Message.text = text
	$Message.show()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		_on_play_pressed()



func _on_play_pressed():
	start_game.emit()
