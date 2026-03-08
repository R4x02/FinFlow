extends Control

# --- ZMIENNE STARTOWE ---
var cash: float = 1000.0
var stock_price: float = 100.0
var stocks: int = 0
var day: int = 1
var volatility: float = 0.1 
var price_history: Array = [100.0]
var graph_width: int = 25 # Szerokość między punktami wykresu 

# --- REFERENCJE ---
@onready var shares_label = $Control/VBoxContainer/SharesLabel
@onready var day_label = $Control/VBoxContainer/DayLabel
@onready var cash_label = $Control/VBoxContainer/CashLabel
@onready var price_label = $Control/VBoxContainer/PriceLabel

@onready var chart = $Control/Line2D # Nasz Line2D 
@onready var settings = $settingsPanel

@onready var cash_input = $settingsPanel/VBoxContainer/Gotówka/Cashinput
@onready var price_input = $settingsPanel/VBoxContainer/Cena/Priceinput
@onready var risk_input = $settingsPanel/VBoxContainer/Ryzyko/Riskinput
@onready var chart_check = $settingsPanel/VBoxContainer/ShowChartCheck

func _ready():
	if settings: settings.hide()
	
	# Inicjalizacja wykresu ze starej wersji 
	if chart:
		chart.clear_points()
		chart.default_color = Color(57/255.0, 255/255.0, 20/255.0) # Neonowy zielony 
		# Dodajemy pierwszy punkt
		chart.add_point(Vector2(0, -stock_price + 400))
		
	update_ui()

# --- LOGIKA HANDLU ---

func _on_buy_button_pressed():
	if cash >= stock_price:
		cash -= stock_price
		stocks += 1
		update_ui()

func _on_sell_button_pressed():
	if stocks > 0:
		cash += stock_price
		stocks -= 1
		update_ui()

# --- SYMULACJA DNIA ---

func _on_next_day_button_pressed():
	day += 1
	var old_price = stock_price
	
	# Losowanie nowej ceny (Twoja logika zmienności)
	var change = randf_range(-volatility, volatility + 0.02)
	stock_price *= (1.0 + change)
	stock_price = max(stock_price, 1.0) # Zabezpieczenie ceny 
	
	update_ui()
	update_chart(old_price) # Przekazujemy starą cenę do koloru 

# --- NOWY WYKRES (Zintegrowany ze starej wersji) ---

func update_chart(old_price):
	if chart == null: return
	
	# Zmiana koloru w zależności od trendu 
	if old_price < stock_price:
		chart.default_color = Color(57/255.0, 255/255.0, 20/255.0) # Zielony 
	else:
		chart.default_color = Color(255/255.0, 49/255.0, 49/255.0) # Czerwony 
	
	# Logika przesuwania punktów (Gdy jest ich więcej niż 20) 
	if chart.get_point_count() > 20:
		chart.remove_point(0)
		for i in range(chart.get_point_count()):
			var p_pos = chart.get_point_position(i)
			chart.set_point_position(i, Vector2(i * graph_width, p_pos.y))
	
	# Dodanie nowego punktu 
	# Wartość 400 to wysokość bazowa, od której odejmujemy cenę 
	chart.add_point(Vector2(chart.get_point_count() * graph_width, -stock_price + 400))

# --- RESZTA FUNKCJI ---

func update_ui():
	if cash_label: cash_label.text = "Portfel: " + str(snapped(cash, 0.01)) + " PLN"
	if price_label: price_label.text = "Cena: " + str(snapped(stock_price, 0.01))
	if shares_label: shares_label.text = "Akcje: " + str(stocks)
	if day_label: day_label.text = "Dzień: " + str(day)

func _on_settings_btn_pressed():
	if settings:
		cash_input.value = cash
		price_input.value = stock_price
		risk_input.value = volatility * 100
		settings.show()

func _on_close_settings_btn_pressed():
	cash = cash_input.value
	stock_price = price_input.value
	volatility = risk_input.value / 100.0
	if chart: chart.visible = chart_check.button_pressed
	settings.hide()
	update_ui()

func _on_btn_exit_2_pressed():
	get_parent().get_parent().show_menu()
