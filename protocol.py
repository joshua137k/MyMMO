import sqlite3
import asyncio
import json
from autobahn.asyncio.websocket import WebSocketServerProtocol, WebSocketServerFactory
import main
import message as msg
import mathJ as m


class MyServerProtocol(WebSocketServerProtocol):

    def __init__(self):
        super().__init__()
        self.visible=True
        self.username = None
        self.id = 0
        self.room = None
        self.position=m.Vector(0,0,0)


    def onConnect(self, request):
        print("Cliente conectado: {}".format(request.peer))
        self.factory.register(self)
        


    def onOpen(self):
        print("Conexão aberta")
        # Enviar informações sobre os mobs para o cliente


    def onClose(self, wasClean, code, reason):
        message = {'type': 'player_disconnected', 'id': self.id}
        self.factory.broadcast_message(message,self)
        client = self.factory.clients[self.id]
        print(message)
        if client:
            self.factory.unregister(self)
        print("Conexão fechada: {}".format(reason))


    def onMessage(self, payload, isBinary):
        msg.Message(self, payload, isBinary)


    def register_user(self, username, password):
        conn = sqlite3.connect('users.db')
        try:

            cursor = conn.cursor()

            # Verifica se já existe um usuário com este username
            cursor.execute("SELECT username FROM users WHERE username = ?", (username,))
            user = cursor.fetchone()
            if user:

                message = {'type': 'system_message', 'text': "Username '{}' is already taken".format(username)}
                self.sendSystemMessage(message)
                print("Username '{}' is already taken".format(username))
                return
            else:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, password))
                conn.commit()
                print("User '{}' registered".format(username))
                message = {'type': 'system_message', 'text': "User '{}' registered".format(username)}
                self.sendSystemMessage(message)
                
        except:
            print("ERROR")

        finally:
            conn.close()


    def login_user(self, username, password):
        conn = sqlite3.connect('users.db')
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, password))
        user = cursor.fetchone()
        islogged=any(self.factory.clients[p].username == username for p in self.factory.clients)
        if user and not(islogged):
            self.username = username
            print("User '{}' logged in".format(username))

            message = {'type': 'player_connected', 'id': self.id}
            self.sendSystemMessage(message)
            self.factory.send_available_rooms(self)
            

        else:
            message = {'type': 'system_message', 'text': "Invalid login credentials for user '{}'".format(username)}
            self.sendSystemMessage(message)
            print("Invalid login credentials for user '{}'".format(username))
        conn.close()
        


    def sendSystemMessage(self,message):
        payload = json.dumps(message).encode('utf8')
        self.sendMessage(payload,isBinary=False)

    def handle_room_choice(self, message):
        self.room = message
        self.factory.rooms[self.room].add_client(self)
        pay={"type":"Logged","id":str(self.id)}
        payload=json.dumps(pay).encode('utf8')
        self.sendMessage(payload,isBinary=False)