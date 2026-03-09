extends Control

var slides = [
	"Witaj w FinFlow! Edukacja to pierwszy krok do zysków.",
	"LEKCJA 1: Inflacja: Dlaczego Twoja kasa „chudnie”?\n
	Inflacja to spadek wartości pieniądza w czasie. Za tę samą stówę kupisz dziś mniej towarów niż rok temu, bo ceny w sklepach rosną. Inwestowanie to sposób, by Twoje oszczędności rosły szybciej niż ceny na półkach.",
	"LEKCJA 2: Procent Składany: Finansowa kula śnieżna\n
	To sytuacja, w której zarabiasz odsetki nie tylko od wpłaconej kasy, ale też od odsetek, które już wcześniej wpadły na konto. Zysk „pracuje” na kolejny zysk. Im wcześniej zaczniesz, tym potężniejszy będzie efekt końcowy.",
	"LEKCJA 3: Dywersyfikacja: Nie stawiaj wszystkiego na jedną kartę\n
	To rozproszenie ryzyka poprzez kupowanie różnych aktywów. Nie wrzucaj całej kasy w jedną firmę, bo jeśli ona upadnie – tracisz wszystko. Portfel powinien być jak dobrze ułożona ekipa w grze: potrzebujesz różnych klas postaci, by przetrwać.",
	"LEKCJA 4: Akcje i ETF-y: Udziały vs Koszyki\n
	Kupując akcję, stajesz się współwłaścicielem konkretnej firmy (np. Apple czy Tesli). ETF to z kolei „gotowy miks” – jeden instrument, który zawiera w sobie ułamki setek różnych firm. ETF jest bezpieczniejszy dla początkujących, bo automatycznie dywersyfikuje Twoją kasę.",
	"LEKCJA 5: Czas to największy sojusznik\n
	To żelazna zasada: im więcej chcesz zarobić, tym więcej musisz zaryzykować. Bezpieczne opcje (jak lokaty) dają małe zyski, bo ryzyko straty jest prawie zerowe. Jeśli ktoś obiecuje Ci „pewną kasę” bez ryzyka – uciekaj, to na 100% scam."
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
