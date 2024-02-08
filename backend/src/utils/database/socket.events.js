export const SOCKET_EVENTS = {
    CONNECT: 'connection',
    DISCONNECT: 'disconnect',
    USER: {
       SERVER_CONNECT: 'user_connect',
       SERVER_ERROR: 'user_error',
       SERVER_UPDATE: 'user_update_list',
       CLIENT_NEW: 'user_new',
       CLIENT_UPDATE: 'user_update',
       CLIENT_DISCONNECT: 'user_disconnect',
    },
    CHAT: {
       SERVER_OPEN: 'chat_open_update',
       SERVER_SEND: 'chat_send_update',
       CLIENT_OPEN: 'chat_open',
       CLIENT_SEND: 'chat_send',
       CLIENT_CLOSE: 'chat_close',
    },
    ROOM: {
       SERVER_SWITCH: 'room_switch_update',
       SERVER_UPDATE: 'room_list_update',
       CLIENT_CREATE: 'room_create',
       CLIENT_SWITCH: 'room_switch',
       CLIENT_UPDATE: 'room_update',
    },
 };
 