-- Enable PostGIS extension if not already enabled
CREATE EXTENSION IF NOT EXISTS postgis;

-- Land polygons table
CREATE TABLE land_polygons (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    geom GEOMETRY(POLYGON, 4326)
);

-- Create spatial index on land polygons
CREATE INDEX land_polygons_geom_idx ON land_polygons USING GIST(geom);

-- Roads table
CREATE TABLE roads (
    osm_id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    geom GEOMETRY(LINESTRING, 4326)
);

-- Create spatial index on roads
CREATE INDEX roads_geom_idx ON roads USING GIST(geom);

-- Buildings table
CREATE TABLE buildings (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    height NUMERIC,
    geom GEOMETRY(POLYGON, 4326)
);

-- Create spatial index on buildings
CREATE INDEX buildings_geom_idx ON buildings USING GIST(geom);

-- Points of interest table
CREATE TABLE points_of_interest (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(50),
    amenity VARCHAR(50),
    geom GEOMETRY(POINT, 4326)
);

-- Create spatial index on points of interest
CREATE INDEX poi_geom_idx ON points_of_interest USING GIST(geom);

-- Sample data insertion for testing
-- Insert a land polygon
INSERT INTO land_polygons (name, type, geom)
VALUES ('Central Park', 'park', 
        ST_GeomFromText('POLYGON((-73.981 40.768, -73.958 40.768, -73.958 40.800, -73.981 40.800, -73.981 40.768))', 4326));

-- Insert a road
INSERT INTO roads (osm_id, name, type, geom)
VALUES (123456789, 'Broadway', 'primary',
        ST_GeomFromText('LINESTRING(-73.985 40.750, -73.980 40.760, -73.975 40.770)', 4326));

-- Insert a building
INSERT INTO buildings (name, height, geom)
VALUES ('Empire State Building', 381,
        ST_GeomFromText('POLYGON((-73.986 40.748, -73.984 40.748, -73.984 40.750, -73.986 40.750, -73.986 40.748))', 4326));

-- Insert a point of interest
INSERT INTO points_of_interest (name, type, amenity, geom)
VALUES ('Times Square', 'tourist', 'plaza',
        ST_GeomFromText('POINT(-73.985 40.758)', 4326));
		
		
-- Table: public.tegola_live_report_poi

-- DROP TABLE IF EXISTS public.tegola_live_report_poi;

CREATE TABLE IF NOT EXISTS public.tegola_live_report_poi
(
    id integer NOT NULL DEFAULT nextval('tegola_live_report_poi_id_seq'::regclass),
    live_report_id uuid NOT NULL,
    categoryid uuid NOT NULL,
    category_name character varying(50) COLLATE pg_catalog."default",
    marker_url character varying(200) COLLATE pg_catalog."default",
    geom geometry(Point,4326) NOT NULL,
    number_of_view integer NOT NULL DEFAULT 0,
    number_of_confirm integer NOT NULL DEFAULT 0,
    number_of_rejection integer NOT NULL DEFAULT 0,
    expired_display_time bigint NOT NULL,
    status character varying(20) COLLATE pg_catalog."default",
    created_at bigint NOT NULL,
    created_by character varying(50) COLLATE pg_catalog."default",
    last_modified bigint NOT NULL,
    last_modified_by character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT tegola_live_report_poi_pkey PRIMARY KEY (id),
    CONSTRAINT "FK_tegola_live_report_poi_live-report_live_report_id" FOREIGN KEY (live_report_id)
        REFERENCES public."live-report" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT "FK_tegola_live_report_poi_traffic-category_categoryid" FOREIGN KEY (categoryid)
        REFERENCES public."traffic-category" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tegola_live_report_poi
    OWNER to postgres;
-- Index: IX_tegola_live_report_poi_categoryid

-- DROP INDEX IF EXISTS public."IX_tegola_live_report_poi_categoryid";

CREATE INDEX IF NOT EXISTS "IX_tegola_live_report_poi_categoryid"
    ON public.tegola_live_report_poi USING btree
    (categoryid ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: IX_tegola_live_report_poi_geom

-- DROP INDEX IF EXISTS public."IX_tegola_live_report_poi_geom";

CREATE INDEX IF NOT EXISTS "IX_tegola_live_report_poi_geom"
    ON public.tegola_live_report_poi USING gist
    (geom)
    TABLESPACE pg_default;
-- Index: IX_tegola_live_report_poi_live_report_id

-- DROP INDEX IF EXISTS public."IX_tegola_live_report_poi_live_report_id";

CREATE INDEX IF NOT EXISTS "IX_tegola_live_report_poi_live_report_id"
    ON public.tegola_live_report_poi USING btree
    (live_report_id ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
