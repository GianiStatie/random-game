extends CharacterBody2D


const SPEED = 80.0

@onready var sprite = $Sprite2D
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	direction = direction.normalized()
	
	if abs(direction.x) != 0:
		sprite.scale.x = sign(direction.x) 
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity == Vector2.ZERO:
		animationState.travel("Idle")
	else:
		animationState.travel("Run")

	move_and_slide()
