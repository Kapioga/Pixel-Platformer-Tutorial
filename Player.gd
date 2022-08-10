extends KinematicBody2D

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	apply_gravity()
	
	#Adds friction
	var input = Vector2.ZERO
	input.x= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input.x==0:
		apply_friction()
	else:
		apply_acceleration(input.x)
		
	if is_on_floor() and Input.is_action_just_pressed("ui_up"): #ensures that it jumps once
		velocity.y=-120

	velocity = move_and_slide(velocity, Vector2.UP) #Moves character and detects collisions/Gravity

#Gravity
func apply_gravity():
	velocity.y+=4

#Friction
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 20)
	
#Movement
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, 50 * amount, 20)
