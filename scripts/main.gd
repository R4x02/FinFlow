extends Node

@onready var menu = $CanvasLayer/MainMenu
@onready var learn = $CanvasLayer/LearningModule
@onready var sim = $CanvasLayer/Simulator

func _ready():
	show_menu()

func show_menu():
	menu.show()
	learn.hide()
	sim.hide()

# Sygnały z Twojego drzewka:
func _on_btn_learn_pressed():
	menu.hide()
	learn.show()

func _on_btn_sim_pressed():
	menu.hide()
	sim.show()

# Te sygnały podepnij pod przyciski btnExit w modułach
func _on_btn_exit_pressed():
	show_menu()
