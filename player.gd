extends CharacterBody2D

enum {
	RUNNING,
	JUMPING,
	FALLING
}

var state = RUNNING	
const SPEED = 30
const JUMP_VELOCITY = -400.0
@onready var anim = get_node("AnimationPlayer")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	

func _physics_process(delta):
	velocity.x = SPEED
	state = RUNNING
	
	if not is_on_floor(): # 공중이라
		velocity.y += gravity * delta
		if velocity.y < 0: 
			state = JUMPING
		else:
			state = FALLING 
#
	## Handle jump.
	if Input.is_action_just_pressed("enter") and is_on_floor():		
		velocity.y = JUMP_VELOCITY	
		velocity.y = move_toward(velocity.y, SPEED, SPEED)
		
	match state:
		RUNNING:
			anim.play("Idle")			
		JUMPING:
			anim.play("Jump")
		FALLING:
			anim.play("Fall")
			
			
	move_and_slide()
