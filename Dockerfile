# pull official base image
FROM public.ecr.aws/docker/library/node:14.19.1-alpine as build-deps
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN apk add git
RUN yarn
COPY . ./
RUN yarn build

FROM public.ecr.aws/docker/library/nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]