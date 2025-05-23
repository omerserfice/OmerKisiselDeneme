# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["OmerKisielDeneme/OmerKisielDeneme.csproj", "OmerKisielDeneme/"]
RUN dotnet restore "OmerKisielDeneme/OmerKisielDeneme.csproj"
COPY . .
WORKDIR "/src/OmerKisielDeneme"
RUN dotnet build "OmerKisielDeneme.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "OmerKisielDeneme.csproj" -c Release -o /app/publish

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "OmerKisielDeneme.dll"]