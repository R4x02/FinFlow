extends Node

# --- ZMIENNE EKONOMICZNE ---
var cash: float = 1000.0
var stock_price: float = 100.0
var shares_owned: int = 0
var current_day: int = 1

# --- REFERENCJE DO UI ---
@onready var cash_label = $UI/Control/VBoxContainer/CashLabel
@onready var price_label = $UI/Control/VBoxContainer/PriceLabel
@onready var shares_label = $UI/Control/VBoxContainer/SharesLabel
@onready var day_label = $UI/Control/VBoxContainer/DayLabel

func _ready():
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
	stock_price = stock_price * (1.0 + change_percent)
	
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
