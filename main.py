import sqlite3
import asyncio
import json
from autobahn.asyncio.websocket import WebSocketServerProtocol, WebSocketServerFactory
import protocol
import Mobs
import mathJ as m
import Room as r



class MyServerFactory(WebSocketServerFactory):
    def __init__(self, url):
        super().__init__(url)
        self.protocol = protocol.MyServerProtocol
        self.clients = {}
        self.id = 0
        self.mob_id=0
        self.rooms = {"Mandi": r.Room(0),"Oca":r.Room(1)}
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        self.create_mob("Mandi")
        

        

        conn = sqlite3.connect('users.db')
        cursor = conn.cursor()

        # cria a tabela "users" caso ela não exista
        cursor.execute('''CREATE TABLE IF NOT EXISTS users
                          (id INTEGER PRIMARY KEY AUTOINCREMENT,
                          username TEXT NOT NULL,
                          password TEXT NOT NULL)''')
        conn.commit()
        # fecha a conexão com o banco de dados
        conn.close()

    def create_mob(self, room_id):
        mob = Mobs.Mob(self.mob_id,room_id,self.mob_id,self)
        self.mob_id+=1

        room = self.rooms[room_id]
        if room:
            room.add_mob(mob)
            

        return mob

    def register(self, client):
        self.clients[self.id] = client
        self.create_player(self.id)
        self.set_player_id(client, self.id)
        self.id += 1
        print(self.rooms["Mandi"].clients)
        # print("Novo cliente registrado. Total de clientes: {}".format(len(self.clients)))
        # print(self.clients)


    def unregister(self, client):
        # print("Cliente removido. Total de clientes: {}".format(len(self.clients)))
        del self.clients[client.id]
        if client.room!=None:
            self.rooms[client.room].remove_client(client)
            
            print(self.rooms[client.room].clients)
   
    def send_available_rooms(self, client):
        room_list = list(self.rooms.keys())
        room_clients=[]
        for i in room_list:
            room_clients.append(len(self.rooms[i].clients))
        message = {
            'type': 'available_rooms',
            'rooms': room_list,
            'number': room_clients
        }
        payload = json.dumps(message).encode('utf8')
        client.sendMessage(payload, isBinary=False)
    def set_player_id(self, client, player_id):
        client.id = player_id

    def create_player(self, player_id):
        conn = sqlite3.connect('players.db')
        c = conn.cursor()

        # cria um novo jogador
        result = c.execute("SELECT * FROM players WHERE id=?", (player_id,)).fetchone()

        if result is None:
            c.execute("INSERT INTO players (id, pos, rot) VALUES (?, ?, ?)", (player_id, "(0,0,0)", "(0,0,0)"))
        conn.commit()
        conn.close()

    def broadcast_message(self, message, client):
        payload = json.dumps(message).encode('utf8')
        
        if client.room!=None:
            for c in self.rooms[client.room].clients:
                if c is not client:
                    try:
                        if c.position.distance_to(client.position)<35:
                            c.visible=True
                            c.sendMessage(payload, isBinary=False)
                        elif c.position.distance_to(client.position)>35:
                            if c.visible:
                                c.visible=False
                                message["visible"]=c.visible
                                payload = json.dumps(message).encode('utf8')
                                c.sendMessage(payload, isBinary=False) 

                        
                                
                    except Exception as e:
                        print(f"Failed to send message to client {c.peer}: {e}")

    def DataUpdate(self,message,entity):
        payload = json.dumps(message).encode('utf8')
        
        if entity.room_id!=None:
            for c in self.rooms[entity.room_id].clients:
                try:
                    if c.position.distance_to(entity.position)<35:
                        entity.visible=True
                        c.sendMessage(payload, isBinary=False)
                    else:
                        if entity.visible:
                            entity.visible=False
                            message["visible"]=c.visible
                            payload = json.dumps(message).encode('utf8')
                            c.sendMessage(payload, isBinary=False)
                            
                except Exception as e:
                    print(f"Failed to send message to client {c.peer}: {e}")

        

async def start_server():
    factory = MyServerFactory("ws://localhost:9000")
    factory.protocol = protocol.MyServerProtocol
    loop = asyncio.get_running_loop()
    await loop.create_server(factory, '0.0.0.0', 9000)

    print("Server started")

    try:
        await asyncio.Future()  # keep the server running
    except asyncio.CancelledError:
        pass
async def main():
    await start_server()

if __name__ == "__main__":
    asyncio.run(main())
