extends Node


@onready var player=preload("res://Sceane/playerAndPeer/player.tscn")
@onready var peer=preload("res://Sceane/playerAndPeer/peer.tscn")


var username="UNK"
var myid=0
var online:bool=false

const GRID_SIZE=2


func ClenSlotData(data)->void:
	data[0].texture=null
	data[0].type=[]
