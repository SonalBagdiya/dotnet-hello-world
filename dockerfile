# Use the official .NET Core SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env

# Set the working directory
WORKDIR /app

# Copy the .NET Core project file and restore dependencies
COPY . .
RUN dotnet restore

# Copy the rest of the application code
#COPY . ./

# Build the application
RUN dotnet publish -c Release -o out

# Create the final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
