extends Control
class_name Inventor_Skill

#Codigo que comanda o inv

#DRAW INV
@export var Colum=4
@export var ItemInColum=5
@onready var PanelSlot:Panel=get_node("Background/ScrollContainer/GridContainer/Slot")
@onready var Draw:GridContainer = get_node("Background/ScrollContainer/GridContainer")
var slots={}
#END

#Aonde são guardados os intens
var Inv = {}

#Um ready para desenhar o inv
func _ready():
	PanelSlot.visible=true
	Draw.columns=Colum
	var k=0
	for i in ItemInColum:
		for j in Colum:
			var newSlot = PanelSlot.duplicate()
			slots[k]=newSlot
			k+=1
			Draw.add_child(newSlot)
	PanelSlot.visible=false
	Draw.size=Vector2(Colum*ItemInColum*16,Colum*ItemInColum*16)
	



func _on_close_pressed():
	visible=false

