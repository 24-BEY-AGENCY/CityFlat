import http from "http";
import app from "./src/app.js";
import dotenv from "dotenv";
import multer from "multer";
/* Imports from project modules */
import {
  connectDatabase,
  disconnectDatabase,
} from "./src/utils/database/database.js";

/* Accessing .env content */
dotenv.config();

/* Defining server's HOSTNAME & PORT */
const hostname = process.env.HOSTNAME;
const port = process.env.PORT;

/* Connecting database */
await connectDatabase();

/* Creating the server */
const server = http.createServer(app);

/* Launching the server */
server.listen(port, () => {
  console.log(`Listening [http://${hostname}:${port}]...`);
});

//konishiwa mina
