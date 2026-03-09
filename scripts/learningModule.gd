extends Control

var slides = [
	"Witaj w FinFlow! Edukacja to pierwszy krok do zysków.",
	"LEKCJA 1: Co to jest akcja?\nTo ułamek własności w firmie.",
	"LEKCJA 2: Ryzyko\nPamiętaj, że giełda to nie tylko zyski, ale i straty!"
]
var current_slide = 0

@onready var label = $SlideArea/Content

func _ready():
	update_display()

func _on_btn_next_pressed():
	if current_slide < slides.size() - 1:
		current_slide += 1
		update_display()

func _on_btn_prev_pressed():
	if current_slide > 0:
		current_slide -= 1
		update_display()

func update_display():
	if label:
		# [center] sprawi, że tekst będzie na środku w poziomie
		label.text = "[center]" + slides[current_slide] + "[/center]"
	else:
		print("BŁĄD: Nie znaleziono noda Content w LearningModule!")
