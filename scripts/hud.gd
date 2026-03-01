extends CanvasLayer

# Notifica al nodo `Main`que el botón ha sido presionado
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("¡Has perdido!")
	# Espera a que MessageTimer termine de contar
	await $MessageTimer.timeout

	$Message.text = "¡Esquiva todo!"
	$Message.show()
	# Crea un contador de un solo tiro y le espera a que termina
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()
