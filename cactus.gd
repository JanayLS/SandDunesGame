extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var Player
var chase = false

func _ready():
		get_node("AnimatedSprite2D").play("idle")
func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("walk")
		Player = get_node("../../Player/Player")
		var direction = (Player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0
	move_and_slide()

func _on_playerdetection_body_entered(body):
	if body.name == "Player":
		chase = true
		
func _on_playerdetection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHP -= 3
		death()

func death():
	Game.Gold += 5
	Utils.saveGame()
	chase = true
	get_node("AnimatedSprite2D").play("death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
