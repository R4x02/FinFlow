extends Node

# --- ZMIENNE EKONOMICZNE ---
var cash: float = 1000.0
var stock_price: float = 100.0
var shares_owned: int = 0
var current_day: int = 1
var graph_width: int = 15

# --- REFERENCJE DO UI ---
@onready var cash_label = $UI/Control/VBoxContainer/CashLabel
@onready var price_label = $UI/Control/VBoxContainer/PriceLabel
@onready var shares_label = $UI/Control/VBoxContainer/SharesLabel
@onready var day_label = $UI/Control/VBoxContainer/DayLabel

@onready var line = $UI/Control/Control/Line2D

func _ready():
	line.clear_points()
	line.default_color = Color(57/255, 255/255, 20/255)
	
	update_ui()

# --- LOGIKA BIZNESOWA ---

func _on_buy_button_pressed():
	if cash >= stock_price:
		cash -= stock_price
		shares_owned += 1
		update_ui()
	else:
		print("Brak środków!")

func _on_sell_button_pressed():
	if shares_owned > 0:
		cash += stock_price
		shares_owned -= 1
		update_ui()
	else:
		print("Nie masz akcji na sprzedaż!")

func _on_next_day_button_pressed():
	current_day += 1
	# Prosta symulacja zmiany ceny: od -10% do +12%
	var change_percent = randf_range(-0.10, 0.12)
	var old_stock_price = stock_price
	stock_price = stock_price * (1.0 + change_percent)
	if old_stock_price < stock_price:
		line.default_color = Color(57/255, 255/255, 20/255) # Zielony kolor
	else:
		line.default_color = Color(255/255, 49/255, 49/255) # Czerwony kolor
	
	if line.get_point_count() > 20:
		line.remove_point(0)
		
		for i in range(line.points.size()):
			var point = line.get_point_position(i)
			line.set_point_position(i, Vector2(i*graph_width,point.y))
	
	line.add_point(Vector2(line.points.size()*graph_width, -stock_price+400))
	
	# Zabezpieczenie, żeby cena nie spadła do zera
	stock_price = max(stock_price, 1.0)
	
	update_ui()

# --- ODŚWIEŻANIE WIDOKU ---

func update_ui():
	# Formatowanie do 2 miejsc po przecinku
	cash_label.text = "Gotówka: " + str(snapped(cash, 0.01)) + " PLN"
	price_label.text = "Cena akcji: " + str(snapped(stock_price, 0.01)) + " PLN"
	shares_label.text = "Posiadane akcje: " + str(shares_owned)
	day_label.text = "Dzień: " + str(current_day)
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
