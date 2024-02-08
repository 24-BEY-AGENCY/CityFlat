import { Server } from 'socket.io';
import { SOCKET_EVENTS } from './socket.events.js';

const SOCKET_PORT = 4567;
const io = new Server(SOCKET_PORT, {
    cors: {
        origin: '*',
    },
    transports: ['websocket'],
});

var users = {};
export function handleSockets() {
    io.on(SOCKET_EVENTS.CONNECT, (socket) => {
        console.log("connected to chat");
        //Setting Client's SocketID
        io.emit(SOCKET_EVENTS.USER.SERVER_CONNECT, {
            socketId: socket.id,
        });

        socket.on("signin", (id) => {
            console.log(id);
            users[id] = socket;
            console.log(users);

        });

        socket.on("message", (msg) => {
            console.log(msg);
            let targetId = msg.targetId;
            if(users[targetId]) users[targetId].emit("message",msg);
        });

        
       
    });




}


function newMessage(id, username, message) {
    return {
        id: id,
        username: username,
        message: message,
    };
}
