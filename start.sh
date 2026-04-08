#!/bin/sh
uvicorn server:app --host 127.0.0.1 --port 8001 &
PORT=8000 HOSTNAME=0.0.0.0 node server.js
