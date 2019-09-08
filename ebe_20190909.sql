CREATE TYPE "test_item" AS ENUM (
  'temp',
  'salinity',
  'ph',
  'turbudty',
  'oxygen',
  'fluo'
);

CREATE TYPE "test_depth" AS ENUM (
  '1',
  '5',
  '10',
  '15',
  '20',
  '25',
  '30',
  '35',
  '40',
  '45',
  '50'
);

CREATE TABLE "admin" (
  "id" SERIAL PRIMARY KEY,
  "account" varchar,
  "password" varchar,
  "hash" varchar,
  "name" varchar,
  "phone" char(10),
  "email" varchar,
  "created" timestamp
);

CREATE TABLE "user" (
  "id" SERIAL PRIMARY KEY,
  "sso_type" enum,
  "token" varchar,
  "refresh_token" varchar,
  "name" varchar,
  "phone" char(10),
  "email" varchar,
  "created" timestamp,
  "modified" timestamp
);

CREATE TABLE "team" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "code" char(10),
  "admin_id" int,
  "created" timestamp
);

CREATE TABLE "team_user" (
  "id" SERIAL PRIMARY KEY,
  "team_id" int,
  "user_id" int,
  "created" timestamp
);

CREATE TABLE "project" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "windfield_id" int,
  "type" project_type,
  "admin_id" int,
  "team_id" int,
  "used_boat" BOOLEAN,
  "used_test_status" BOOLEAN
);

CREATE TABLE "windfield" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "location" path,
  "vendor" varchar,
  "created" timestamp,
  "modified" timestamp
);

CREATE TABLE "station" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "lat" "FLOAT(10, 6 )",
  "long" "FLOAT(10, 6 )",
  "created" timestamp,
  "modified" timestamp,
  "port_id" int,
  "datum" char(5)
);

CREATE TABLE "boat" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "photo" varchar,
  "number" varchar
);

CREATE TABLE "port" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "location" point
);

CREATE TABLE "survey" (
  "id" SERIAL PRIMARY KEY,
  "project_id" int,
  "date" date,
  "estimated_hour" int,
  "created" timestamp,
  "modified" timestamp
);

CREATE TABLE "survey_boat" (
  "id" SERIAL PRIMARY KEY,
  "survey_id" int,
  "boat_id" int
);

CREATE TABLE "survey_team_user" (
  "id" SERIAL PRIMARY KEY,
  "survey_id" int,
  "team_user_id" int
);

CREATE TABLE "survey_station" (
  "id" SERIAL PRIMARY KEY,
  "survey_id" int,
  "station_id" int
);

CREATE TABLE "survey_report" (
  "id" SERIAL PRIMARY KEY,
  "survey_id" int,
  "start_date" date,
  "start_time" time,
  "end_date" date,
  "end_time" time,
  "note" text,
  "created" timestamp,
  "modified" timestamp
);

CREATE TABLE "survey_report_team_user" (
  "id" SERIAL PRIMARY KEY,
  "survey_report_id" int,
  "team_user_id" int
);

CREATE TABLE "survey_report_photo" (
  "id" SERIAL PRIMARY KEY,
  "survey_report_id" int
);

CREATE TABLE "witness" (
  "id" SERIAL PRIMARY KEY,
  "witness_time" datetime,
  "left_time" datetime,
  "witness_location" point,
  "contact_location" point,
  "left_location" point,
  "witness_range" varchar,
  "datum" char(5)
);

CREATE TABLE "surveyline" (
  "in" SERIAL PRIMARY KEY,
  "no" varchar,
  "method" varchar,
  "direction" varchar,
  "miles" varchar,
  "hours" varchar,
  "witness_id" int
);

CREATE TABLE "env" (
  "id" SERIAL PRIMARY KEY,
  "station_id" int,
  "witness_id" int,
  "test_depth" test_depth,
  "test_item" test_item,
  "max_depth" varchar,
  "min_depth" varchar,
  "median_particle" varchar,
  "organic_carbon" varchar,
  "avg_depth" varchar,
  "avg_salinity" varchar,
  "avg_ph" varchar,
  "avg_temp" varchar,
  "avg_turbudty" varchar,
  "avg_oxygen" varchar,
  "wave_scale" varchar,
  "weather" varchar,
  "glare" varchar,
  "fishboat_move" int,
  "fistboat_stop" int,
  "freighter_move" int,
  "frieghter_stop" int,
  "workvessel_move" int,
  "workvessel_stop" int,
  "offshore_rough" varchar,
  "offshore_precise" varchar,
  "from_fulltide" int,
  "note" text
);

ALTER TABLE "team" ADD FOREIGN KEY ("admin_id") REFERENCES "admin" ("id");

ALTER TABLE "team_user" ADD FOREIGN KEY ("team_id") REFERENCES "team" ("id");

ALTER TABLE "team_user" ADD FOREIGN KEY ("user_id") REFERENCES "user" ("id");

ALTER TABLE "project" ADD FOREIGN KEY ("windfield_id") REFERENCES "windfield" ("id");

ALTER TABLE "project" ADD FOREIGN KEY ("admin_id") REFERENCES "admin" ("id");

ALTER TABLE "project" ADD FOREIGN KEY ("team_id") REFERENCES "team" ("id");

ALTER TABLE "station" ADD FOREIGN KEY ("port_id") REFERENCES "port" ("id");

ALTER TABLE "survey" ADD FOREIGN KEY ("project_id") REFERENCES "project" ("id");

ALTER TABLE "survey_boat" ADD FOREIGN KEY ("survey_id") REFERENCES "survey" ("id");

ALTER TABLE "survey_boat" ADD FOREIGN KEY ("boat_id") REFERENCES "boat" ("id");

ALTER TABLE "survey_team_user" ADD FOREIGN KEY ("survey_id") REFERENCES "survey" ("id");

ALTER TABLE "survey_team_user" ADD FOREIGN KEY ("team_user_id") REFERENCES "team_user" ("id");

ALTER TABLE "survey_station" ADD FOREIGN KEY ("survey_id") REFERENCES "survey" ("id");

ALTER TABLE "survey_station" ADD FOREIGN KEY ("station_id") REFERENCES "station" ("id");

ALTER TABLE "survey_report" ADD FOREIGN KEY ("survey_id") REFERENCES "survey" ("id");

ALTER TABLE "survey_report_team_user" ADD FOREIGN KEY ("survey_report_id") REFERENCES "survey_report" ("id");

ALTER TABLE "survey_report_team_user" ADD FOREIGN KEY ("team_user_id") REFERENCES "team_user" ("id");

ALTER TABLE "survey_report_photo" ADD FOREIGN KEY ("survey_report_id") REFERENCES "survey_report" ("id");

ALTER TABLE "surveyline" ADD FOREIGN KEY ("witness_id") REFERENCES "witness" ("id");

ALTER TABLE "env" ADD FOREIGN KEY ("station_id") REFERENCES "station" ("id");

ALTER TABLE "env" ADD FOREIGN KEY ("witness_id") REFERENCES "witness" ("id");
