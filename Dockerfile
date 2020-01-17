# NuGet restore
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src
# COPY *.sln .
COPY *.csproj .
RUN dotnet restore
COPY . .

# publish
FROM build AS publish
WORKDIR /src/E-Manager
RUN dotnet publish -c Release

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY . .
# ENTRYPOINT ["dotnet", "Colors.API.dll"]
# heroku uses the following
CMD ASPNETCORE_URLS=http://*:$PORT dotnet EManager3.dll
