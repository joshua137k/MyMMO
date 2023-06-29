extends Node







const ultimo=9000
enum Element{fire,water,dirt,air,none=ultimo}
enum magic_Attacks{magic_ball,magic_spike,none=ultimo}
enum sword_Attacks{sword_Slash,none=ultimo}
enum bow_Attacks{bow_OneArrow,none=ultimo}
enum axe_Attacks{axe_Slash,none=ultimo}
enum trap_Attacks{trap_mouseTrap,none=ultimo}
enum rune_Attacks{rune_addForce,none=ultimo}
enum shield_Attacks{shiel_block,none=ultimo}


const sword_attacks_db = {
	sword_Attacks.sword_Slash: {
		"name": "Ataque Espada",
		"description": "Um ataque básico com espada",
		"damage": 20,
		"cooldown": 1.0,
		"assest3D":preload("res://Sceane/Skills/melee/sword.tscn")
	}
}


const magic_attacks_db = {
	magic_Attacks.magic_ball: {
		"name": "Ball_Magic",
		"description": "Lança uma bola de magia no alvo",
		"damage": 50,
		"cooldown": 5.0,
		"assest3D":preload("res://Sceane/Skills/magics/Ball_Magic.tscn")
	},
	magic_Attacks.magic_spike: {
		"name": "Spike_Magic",
		"description": "Lança uma Espinhos de magia no alvo",
		"damage": 100,
		"cooldown": 10.0,
		"assest3D":preload("res://Sceane/Skills/magics/spike_Magic.tscn")
	}
}


const bow_attacks_db = {
	bow_Attacks.bow_OneArrow: {
		"name": "Flecha Única",
		"description": "Dispara uma flecha única em direção ao alvo",
		"damage": 30,
		"cooldown": 2.0,
		"assest3D": preload("res://Sceane/Skills/ranged/bow.tscn")
	}
}


const axe_attacks_db = {
	axe_Attacks.axe_Slash: {
		"name": "Corte de Machado",
		"description": "Desfere um golpe horizontal com o machado",
		"damage": 35,
		"cooldown": 2.5,
		"assest3D": preload("res://Sceane/Skills/melee/axe.tscn")
	}
}


const trap_attacks_db = {
	trap_Attacks.trap_mouseTrap: {
		"name": "Armadilha de Rato",
		"description": "Coloca uma armadilha de rato no chão para capturar inimigos",
		"damage": 0,
		"cooldown": 5.0,
		"assest3D": preload("res://Sceane/Skills/traps/mouseTrap.tscn")
	}
}


const rune_attacks_db = {
	rune_Attacks.rune_addForce: {
		"name": "Runa de Força",
		"description": "Aplica um impulso de força em um alvo",
		"damage": 15,
		"cooldown": 1.5,
		"assest3D": preload("res://Sceane/Skills/runes/forceRune.tscn")
	}
}


const shield_attacks_db = {
	shield_Attacks.shiel_block: {
		"name": "Bloqueio com Escudo",
		"description": "Bloqueia um ataque inimigo com o escudo",
		"damage": 0,
		"cooldown": 3.0,
		"assest3D": preload("res://Sceane/Skills/defense/shield.tscn")
	}
}


const elements_db = {
	Element.fire: {
		"name": "Fogo",
		"description": "Um elemento ardente que queima o alvo",
		"effect": "Adiciona 10 de dano de fogo ao ataque",
		"color":Color("ff261e"),
		"assestMagic":preload("res://resource/effects/fire.tres")
	},
	Element.dirt: {
		"name": "Terra",
		"description": "Um elemento sólido que fortalece a defesa",
		"effect": "Aumenta a defesa do usuário em 20%",
		"color":0,
		"assestMagic":0
	},
	Element.air: {
		"name": "Ar",
		"description": "Um elemento gasoso que aumenta a velocidade",
		"effect": "Aumenta a velocidade do usuário em 50%",
		"color":Color("ffffff"),
		"assestMagic":preload("res://resource/effects/air.tres")
	},
	Element.water: {
		"name": "Água",
		"description": "Um elemento líquido que enfraquece o ataque",
		"effect": "Reduz o dano do ataque do alvo em 50%",
		"color":Color("355abd"),
		"assestMagic":preload("res://resource/effects/water.tres")
	}
}

