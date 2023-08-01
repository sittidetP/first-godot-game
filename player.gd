extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var jump_amount = 2
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var coyote_jump_timer = $CoyoteJumpTimer

var current_jump_amount = 0
var was_on_floor = true
var use_jump_when_coyote = false
var jumped = false

var start_position

func _ready():
	start_position = global_position
	current_jump_amount = jump_amount
	
func _process(delta):
	var is_falling = not is_on_floor() and velocity.y >= 0.0

	#when falling from ground -> start the coyote_jump_timer
	if was_on_floor and not is_falling:
		coyote_jump_timer.start()
		was_on_floor = false
	
	#decrese current jump amount when falling and coyote_jump_timer is timeout
	var can_jump_only_one = current_jump_amount > 0 and jump_amount == 1
	var is_coyoting = is_falling and coyote_jump_timer.time_left <= 0
	if  not jumped and is_coyoting  and can_jump_only_one and not use_jump_when_coyote:
		current_jump_amount -= 1
		use_jump_when_coyote = true
	
	reset_vars_when_on_floor()

func _physics_process(delta):
	add_gravity(delta)
	
	var direction = Input.get_axis("move_left", "move_right")
	handle_jump()
	
	handle_move(direction)
	
	handle_animation(direction)

	move_and_slide()
	
func add_gravity(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
func handle_jump():
	# Handle Jump.
	
	if Input.is_action_just_pressed("jump") and current_jump_amount > 0:
		jumped = true
		was_on_floor = false
		velocity.y = JUMP_VELOCITY
		current_jump_amount -= 1
		

func handle_move(direction: float):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func reset_vars_when_on_floor():
	if is_on_floor():
		jumped = false
		use_jump_when_coyote = false
		was_on_floor = true
		current_jump_amount = jump_amount
		
func handle_animation(direction: float):
	if direction != 0.0:
		animated_sprite_2d.play("run")
		var is_turn_left = direction < 0.0
		animated_sprite_2d.flip_h = is_turn_left
	else :
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func _on_hazard_detector_area_entered(area):
	global_position = start_position
