extends KinematicBody2D

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	velocity.y +=2
	#Buttons
	if Input.is_action_just_pressed("ui_right"):
		velocity.x=10
	elif Input.is_action_just_pressed("ui_left"):
		velocity.x=-10
		
	velocity = move_and_slide(velocity) #Moves character and detects collisions/Gravity
