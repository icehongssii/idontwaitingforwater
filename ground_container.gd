extends Node2D
const ground = preload("res://tile_map.tscn")
const groundwidth = 3148
var spawn_position = global_position
@onready var player = get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO! initialize 할때도 호출되는데 이는 player.global_position.x가 처음에 6
	# spawn_position.x가 0이라서.. ㅜ
	if player.global_position.x > spawn_position.x - groundwidth: # Add a buffer of 100 units
		spawn_ground()


func spawn_ground():		
	var instance = ground.instantiate()
	#screen_enabler.connect("screen_exited", on_screen_enabler_screen_exited)
	add_child(instance)
	instance.global_position.x = spawn_position.x
	instance.global_position.y = 109
	spawn_position.x += groundwidth


 	# TODO! 처음에 인스턴스가 두개씩 생성돼서 강제로 삭제 화면에서 삭ㅈ제 부자연스러
	if get_child_count() > 2 :
		get_children()[0].queue_free()

