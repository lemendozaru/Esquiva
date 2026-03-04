extends Area2D

signal hit

@export var speed = 400
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # vector de movimiento del jugador
	if Input.is_action_pressed("derecha"):
		velocity.x += 1
	if Input.is_action_pressed("izquierda"):
		velocity.x -= 1
	if Input.is_action_pressed("abajo"):
		velocity.y += 1
	if Input.is_action_pressed("arriba"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) # clamp evita salir de pantalla
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "caminar"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "arriba"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D):
	hide() # Player desaparece al ser golpeado
	hit.emit() # se emite la señal de ser golpeado
	# Debe apagarse la emisión de señal para que no se repita 
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
