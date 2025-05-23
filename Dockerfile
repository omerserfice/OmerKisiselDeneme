# Build aşaması
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["OmerKisiselDeneme/OmerKisiselDeneme.csproj", "OmerKisiselDeneme/"]
RUN dotnet restore "OmerKisiselDeneme/OmerKisiselDeneme.csproj"
COPY . .
WORKDIR "/src/OmerKisiselDeneme"
RUN dotnet build "OmerKisiselDeneme.csproj" -c Release -o /app/build

# Publish aşaması
FROM build AS publish
RUN dotnet publish "OmerKisiselDeneme.csproj" -c Release -o /app/publish

# Runtime aşaması
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "OmerKisiselDeneme.dll"]