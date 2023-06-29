import random
import asyncio
import mathJ as m
import DugeonMap as d
import math



class Mob:
    def __init__(self, mob_id,room_id,name,factory):
        self.visible=True
        self.factory=factory
        self.name=name
        self.mob_id = mob_id
        self.room_id=room_id
        self.start_position = d.choose_random_position()
        self.position = m.Vector(self.start_position[0],0.45,self.start_position[1])
        self.health = 100
        self.rotation = m.Vector(0, 0, 0)
        self.path ={}
        self.next_position=(self.position.x,self.position.z)
        self.anim='idle_'


    def attack_player(self, player):
        # Lógica de ataque ao jogador
        pass

    def wander(self):

        if not self.path:
            dungeon_map = d.dungeon_map

            # Encontra o caminho usando o algoritmo A*
            start = (round(self.position.x), round(self.position.z))
            end = d.choose_random_position()
            
            self.path = d.astar(dungeon_map,start, end)
            

        if self.path:
            # Se ainda houver um caminho disponível, move-se para o próximo ponto no caminho
            target_position = m.Vector(self.next_position[0], 0, self.next_position[1])
            direction = target_position - self.position
            distance = direction.magnitude()
            # Calcula a rotação desejada
            rot = math.atan2(direction.normalized().x, direction.normalized().z)
            self.rotation.y = -rot
            if distance > 0.49:
                # Se a distância for maior que 0.1, calcula o incremento em 0.1
                increment = direction.normalized() * 0.1
                self.position = m.Vector(self.position.x+increment.x,self.position.y,self.position.z+increment.z)

            else:
                # Se a distância for menor ou igual a 0.1, chegou ao próximo ponto do caminho
                self.position = m.Vector(target_position.x,self.position.y,target_position.z)
                if self.path:
                    self.next_position = self.path.pop(0)

    def updatePos(self):
        p = ( (self.position.x),(self.position.y),(self.position.z))
        r=((self.rotation.x),(self.rotation.y),(self.rotation.z))
        message = {
            'type': 'mobs_data',
            'visible':self.visible,
            'id': self.mob_id,
            'position':str(p),
            'rotation':str(r),
            'health': self.health,
            'Anim':self.anim
        }
        self.factory.DataUpdate(message,self)




    async def start_wandering(self):
        while True:
            self.wander()
            self.updatePos()
            await asyncio.sleep(0.04)
