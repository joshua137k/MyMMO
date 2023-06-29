extends Panel

#Script do Slot
@export var get_inv:NodePath
@onready var Inv:Control = get_node(get_inv)
@onready var texture=get_node("Skill_item")


#Pode Dropar em cima apenas Itens, 
func _can_drop_data(_position, data):
	#(texture.id==-1 or texture.id==data.id) Condição nesseraria para impedir que coloquemos 
	#um item diferente de outro no mesmo slot
	if data is Array:
		var can_drop:bool = data[0] is skill_item and (texture.type==[] or texture.type==data[0].type)
		return can_drop
	return false


func _drop_data(_position, data):
	
	EqualsItens(data)
	#Verificar se é um item fisico fora do inv, se for
	#ele morre, se for de inv ele apenas apaga a textura
	if !data[0].itemInSLot:
		data[0].queue_free()
	else:
		Global.ClenSlotData(data)
	
	return self

func EqualsItens(data)->void:
	#Verificar se o item no grab é o mesmo no slot
	#Se o item não existir, então vai colocar o item no slot
	texture.type=data[0].type
	texture.texture=data[0].texture


	
