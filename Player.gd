extends KinematicBody2D

var velocity = Vector2.ZERO

#The initialize function
func _ready():
	pass

#Every physics frame in game
func _physics_process(delta):
	velocity.y +=2
	move_and_slide(velocity) #Moves character and detects collisions/Gravity
