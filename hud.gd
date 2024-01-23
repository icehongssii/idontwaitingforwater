extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_play_pressed():
	$Title.visible = false
	$Playbutton.visible = false
	$"Hud-char_excalidraw".visible = false
	$Cartoonballon_excalidraw.visible = false
	$CPUParticles2D.visible = false
	start_game.emit()
