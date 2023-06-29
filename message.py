import json
import mathJ as m

def Message(self, payload, isBinary):
            #print("Mensagem de texto recebida: {}".format(payload.decode('utf8')))
    data = json.loads(payload.decode('utf8'))
    match data['type']:
        case 'player_position':
            message = {'type': 'player_position', 'id': data['id'],'visible':self.visible, 'data':data['data'], "username":self.username}
            
            self.position=m.StringToVector(data['data'][0])
            self.factory.broadcast_message(message,self)
        case 'attack_mob':
            mob_id = message['mob_id']
            mob = self.get_mob_by_id(mob_id)
            if mob:
                mob.attack_player(self)
                self.factory.broadcast_message({
                    'type': 'mob_health_update',
                    'mob_id': mob_id,
                    'health': mob.health
                }, self)
        case 'chat_message':
            # enviar a mensagem de chat para todos os clientes conectados, exceto o remetente original
            print("Mensagem de texto recebida: {}".format(payload.decode('utf8')))
            message = {'type': 'chat_message', 'username':self.username, 'text': data['text']}
            self.factory.broadcast_message(message,self)
        case 'register':
            self.register_user(data["username"],data["password"])
        case 'login':
            self.login_user(data["username"], data["password"])
        case 'room_choice':
            self.handle_room_choice(data["room_id"])

