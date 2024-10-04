# Reference: https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=linux&pivots=dotnet-8-0

# The following Dockerfile is a multi-stage build that builds a .NET 8 application in a container.
# The first stage uses the .NET SDK image to restore, build, and publish the application.
# The second stage uses the .NET runtime image to run the application.
# The final image is smaller because it only contains the published output of the application.

FROM mcr.microsoft.com/dotnet/sdk:8.0@sha256:35792ea4ad1db051981f62b313f1be3b46b1f45cadbaa3c288cd0d3056eefb83 AS build-env
WORKDIR /App
EXPOSE 80

# Copy everything
ADD https://github.com/saeedmaghdam/WebSocket.git ./src/

# Restore as distinct layers
RUN dotnet restore ./src/WebSocketServer/WebSocketServer.csproj

# Build
RUN dotnet build -c Release --no-restore ./src/WebSocketServer/WebSocketServer.csproj

# Build and publish a release
RUN dotnet publish -c Release --no-restore -o ./out ./src/WebSocketServer/WebSocketServer.csproj

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0@sha256:6c4df091e4e531bb93bdbfe7e7f0998e7ced344f54426b7e874116a3dc3233ff
WORKDIR /App
COPY --from=build-env /App/out .

ENV ASPNETCORE_URLS=http://+:80
RUN chmod +x ./WebSocketServer

ENTRYPOINT ["./WebSocketServer"]