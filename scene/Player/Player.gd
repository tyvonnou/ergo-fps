extends KinematicBody

signal falling()

# Constants
const WALK_SPEED = 5.0
const RUN_SPEED = 15.0
 
# physics
var move_speed := 5.0
var jump_force := 5.0
var gravity := 18.0
var falling_gravity_minus := 0.0
 
# cam look
var min_look_angle := -90.0
var max_look_angle := 90.0
var look_sensitivity := 0.5
 
# vectors
var vel := Vector3()
var mouse_delta := Vector2() 

# player components
onready var bullet_scene := preload("res://scene/AreaBullet/AreaBullet.tscn")
onready var streams := [preload("res://sound/piou/piou.ogg"), preload("res://sound/piou/piou1.ogg")]
onready var camera := $Camera
onready var arm_right := $Camera/MeshArmRight/Muzzle
onready var audio_player := $AudioStreamPlayer
onready var menu_pause := $MenuPause
var ready_shoot := true

# called when we press the shoot button - spawn a new bullet
func shoot():
	if !ready_shoot:
		return
	var bullet = bullet_scene.instance()
	get_parent().add_child(bullet)
 
	bullet.global_transform = arm_right.global_transform
	bullet.scale = Vector3.ONE

	audio_player.stream = Global.rand_pick(streams)
	audio_player.play()
	ready_shoot = false

func playing_mode(playing: bool) -> void:
	set_process(playing)
	set_physics_process(playing)

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.connect("play_mode", self, "playing_mode", [true])
	Global.connect("cinematic_mode", self, "playing_mode", [false])
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta = event.relative

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
	
	if Input.is_action_pressed("fire"):
		call_deferred("shoot")

func _physics_process(delta: float) -> void:
	vel.x = 0
	vel.z = 0
	var input := Vector2()
	
	# movement inputs
	if Input.is_action_just_pressed("run_mode"):
		move_speed = RUN_SPEED
	if Input.is_action_just_released("run_mode"):
		move_speed = WALK_SPEED
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
	vel.y -= (gravity - falling_gravity_minus) * delta
 
	# move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	# jump if we press the jump button and are standing on the floor
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y = jump_force

	if transform.origin.y < 0:
		emit_signal("falling")

func _on_TimerShoot_timeout() -> void:
	ready_shoot = true
