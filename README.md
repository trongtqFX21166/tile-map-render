# Tegola Vector Tile Server

This project sets up a Tegola MVT server with PostGIS using Docker.

## Getting Started

1. Run the setup script to create the necessary files and directories:
   ```
   ./scripts/setup.sh
   ```

2. Start the services:
   ```
   docker-compose up -d
   ```

3. Access the vector tiles at:
   - Vector Tiles: `http://localhost:8080/maps/basemap/{z}/{x}/{y}.pbf`
   - Map Viewer: `http://localhost:8080/maps/basemap/`
   - Capabilities: `http://localhost:8080/capabilities`

## Folder Structure

- `/config`: Configuration files for Tegola, Nginx, and environment variables
- `/sql`: SQL scripts for database initialization and PostGIS functions
- `/data`: Data files for import
- `/scripts`: Helper scripts
- `/styles`: Map styles for clients
- `/cache`: Tile cache directory
