import asyncio

class Room:
    def __init__(self, room_id):
        self.room_id = room_id
        self.clients = []
        self.mobs = []
        
    
    def add_mob(self, mob):
        self.mobs.append(mob)
        asyncio.create_task(mob.start_wandering())

    def remove_mob(self, mob):
        self.mobs.remove(mob)

    def add_client(self, client):
        self.clients.append(client)

    def remove_client(self, client):
        self.clients.remove(client)
