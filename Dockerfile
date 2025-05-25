# Dockerfile

# ---------------------------------------------------------------------------
# Download Godot and Export Templates
# ---------------------------------------------------------------------------
FROM ubuntu:noble AS download
RUN apt-get update && apt-get install -y curl unzip
WORKDIR /
COPY dependencies.sh dependencies.sh
COPY tools tools
RUN tools/ci/install_godot

# ---------------------------------------------------------------------------
# Build PeraPeraQuest using Godot; Export to Web
# ---------------------------------------------------------------------------
FROM download AS build
RUN apt-get install -y fontconfig
WORKDIR /build
COPY . .
RUN mkdir -p export/web
RUN /tools/ci/export_web

# ---------------------------------------------------------------------------
# Publish a container image to serve PeraPeraQuest with nginx
# ---------------------------------------------------------------------------
FROM nginx:alpine AS game
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /build/export/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
