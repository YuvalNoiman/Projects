import websockets
import asyncio
import maintenance

#server data
Port = 7000

print ("Started on server and it's listening on port" + str(Port))

m = maintenance.Maintenance()
async def echo(websocket, path):
    success = 0
    print("formed connection with new client")
    async for message in websocket:
        print("Recieved message: " + str(message))
        if ("Ticket Data" in message):
            #elements in order: cwid, emergency, category, lcation, description.
            dataElements = message[12:].split(":,")
            #add locational format: cwid. Location, description, category, emergency.
            m.add_locational(dataElements[0], dataElements[3],dataElements[4], dataElements[2], dataElements[1])
            success = 1
            await websocket.send("Ticket recieved and logged.")

        if("PassGet:" in message):
            Email = message[8:]
            password = m.get_Pass(Email)
            await websocket.send(password)

        if ("Login Attempt" in message):
            dataElements = message[14:].split(":,")
            cwid = m.login(dataElements[0],dataElements[1])
            print(dataElements)
            if (cwid != -1 and cwid != 0):
                cwid = str(cwid)
                await websocket.send("Valid Login:"+cwid)
            else:
                await websocket.send("Incorrect Login")
        if ("Signup Attempt" in message):
            dataElements = message[14:].split(":,")
            m.add_personal(dataElements[0], dataElements[1], dataElements[2], dataElements[3], dataElements[4],dataElements[5])
            await websocket.send("SignUp Success")

start_server = websockets.serve(echo,"localhost", Port)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
