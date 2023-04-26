extends CanvasLayer


signal confirm_pressed
signal cancel_pressed

@onready var confirm_button: Button = %ConfirmButton
@onready var cancel_button: Button = %CancelButton


func _ready() -> void:
	confirm_button.pressed.connect(on_confirm_button_pressed)
	cancel_button.pressed.connect(on_cancel_button_pressed)


func close_dialog():
	queue_free()


func on_confirm_button_pressed():
	confirm_pressed.emit()
	close_dialog()


func on_cancel_button_pressed():
	cancel_pressed.emit()
	close_dialog()
