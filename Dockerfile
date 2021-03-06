FROM node:16-alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . . 
CMD ["npm","run","build "]

FROM nginx

# We have to expose a port from the container to the outside world
EXPOSE 80
# everything from 'usr/share/nginx/html' will be automatically 
# servered up by nginx when it starts up 
COPY --from=builder /app/build /usr/share/nginx/html

# default command of the nginx container is going to start up nginx 
