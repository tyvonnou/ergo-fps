extends KinematicBody

# stats
var curHp : int = 10
var maxHp : int = 10
var ammo : int = 15
var score : int = 0
 
# physics
var move_speed : float = 5.0
var jump_force : float = 5.0
var gravity : float = 12.0
 
# cam look
var min_look_angle : float = -90.0
var max_look_angle : float = 90.0
var look_sensitivity : float = 0.5
 
# vectors
var vel : Vector3 = Vector3()
var mouse_delta : Vector2 = Vector2()
 
# player components
onready var camera = get_node("Camera")

func _input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# rotate camera along X axis
	camera.rotation_degrees -= Vector3(rad2deg(mouse_delta.y), 0, 0) * look_sensitivity * delta
 
	# clamp the vertical camera rotation
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_look_angle, max_look_angle)
 
	# rotate player along Y axis
	rotation_degrees -= Vector3(0, rad2deg(mouse_delta.x), 0) * look_sensitivity * delta
 
	# reset the mouse delta vector
	mouse_delta = Vector2()

func _physics_process(delta):
	vel.x = 0
	vel.z = 0
	var input = Vector2()
	
	# movement inputs
	if Input.is_action_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_pressed("move_backward"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
 
	# normalize the input so we can't move faster diagonally
	input = input.normalized()
	
	# get our forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x	

	# set the velocity
	vel.z = (forward * input.y + right * input.x).z * move_speed
	vel.x = (forward * input.y + right * input.x).x * move_speed

	# apply gravity
	vel.y -= gravity * delta
 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jump_force
