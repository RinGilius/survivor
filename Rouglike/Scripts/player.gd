extends CharacterBody2D

var speed = 10000

@onready var anim = $AnimatedSprite2D

var is_in_des = false

var jump_velocity = -25000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	position = GameManager.change_position
	anim.play("player_idle")
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("player_jump"):
		if is_on_floor():
			velocity.y = jump_velocity * delta
	var direction = Input.get_axis("player_left","player_right")
	velocity.x = direction * speed * delta
	destructive()
	animate()
	move_and_slide()

func animate():
	if velocity.x > 0:
		anim.flip_h = false
	elif velocity.x < 0:
		anim.flip_h = true
	if velocity.x:
		anim.play("player_move")
	else:
		anim.play("player_idle")


func _on_area_enemys_area_entered(area):
	is_in_des = true

func _on_area_enemys_area_exited(area):
	is_in_des = false

func destructive():
	if is_in_des == true and Input.is_action_just_pressed("is_move_box"):
		$"../DestructiveObject".queue_free()
