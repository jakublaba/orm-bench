-- ==================================================
-- IMDb Data Load Script (robust, client-side \copy, gzip)
-- ==================================================

-- ==================================================
-- 1. title.akas
-- ==================================================
CREATE TEMP TABLE title_akas_raw (
    title_id TEXT,
    ordering TEXT,
    title TEXT,
    region TEXT,
    language TEXT,
    types TEXT,
    attributes TEXT,
    is_original_title TEXT
);

\copy title_akas_raw FROM PROGRAM 'gunzip -c data/imdb/title.akas.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_akas
SELECT
    title_id,
    ordering::INTEGER,
    title,
    region,
    language,
    string_to_array(types, ','),
    string_to_array(attributes, ','),
    is_original_title::BOOLEAN
FROM title_akas_raw;

DROP TABLE title_akas_raw;

-- ==================================================
-- 2. title.basics
-- ==================================================
CREATE TEMP TABLE title_basics_raw (
    tconst TEXT,
    title_type TEXT,
    primary_title TEXT,
    original_title TEXT,
    is_adult TEXT,
    start_year TEXT,
    end_year TEXT,
    runtime_minutes TEXT,
    genres TEXT
);

\copy title_basics_raw FROM PROGRAM 'gunzip -c data/imdb/title.basics.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_basics
SELECT
    tconst,
    title_type,
    primary_title,
    original_title,
    is_adult::BOOLEAN,
    start_year::INTEGER,
    end_year::INTEGER,
    runtime_minutes::INTEGER,
    string_to_array(genres, ',')
FROM title_basics_raw;

DROP TABLE title_basics_raw;

-- ==================================================
-- 3. title.crew
-- ==================================================
CREATE TEMP TABLE title_crew_raw (
    tconst TEXT,
    directors TEXT,
    writers TEXT
);

\copy title_crew_raw FROM PROGRAM 'gunzip -c data/imdb/title.crew.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_crew
SELECT
    tconst,
    string_to_array(directors, ','),
    string_to_array(writers, ',')
FROM title_crew_raw;

DROP TABLE title_crew_raw;

-- ==================================================
-- 4. title.episode
-- ==================================================
CREATE TEMP TABLE title_episode_raw (
    tconst TEXT,
    parent_tconst TEXT,
    season_number TEXT,
    episode_number TEXT
);

\copy title_episode_raw FROM PROGRAM 'gunzip -c data/imdb/title.episode.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_episode
SELECT
    tconst,
    parent_tconst,
    season_number::INTEGER,
    episode_number::INTEGER
FROM title_episode_raw;

DROP TABLE title_episode_raw;

-- ==================================================
-- 5. title.principals
-- ==================================================
CREATE TEMP TABLE title_principals_raw (
    tconst TEXT,
    ordering TEXT,
    nconst TEXT,
    category TEXT,
    job TEXT,
    characters TEXT
);

\copy title_principals_raw FROM PROGRAM 'gunzip -c data/imdb/title.principals.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_principals
SELECT
    tconst,
    ordering::INTEGER,
    nconst,
    category,
    job,
    characters
FROM title_principals_raw;

DROP TABLE title_principals_raw;

-- ==================================================
-- 6. title.ratings
-- ==================================================
CREATE TEMP TABLE title_ratings_raw (
    tconst TEXT,
    average_rating TEXT,
    num_votes TEXT
);

\copy title_ratings_raw FROM PROGRAM 'gunzip -c data/imdb/title.ratings.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO title_ratings
SELECT
    tconst,
    average_rating::NUMERIC(3,1),
    num_votes::INTEGER
FROM title_ratings_raw;

DROP TABLE title_ratings_raw;

-- ==================================================
-- 7. name.basics
-- ==================================================
CREATE TEMP TABLE name_basics_raw (
    nconst TEXT,
    primary_name TEXT,
    birth_year TEXT,
    death_year TEXT,
    primary_profession TEXT,
    known_for_titles TEXT
);

\copy name_basics_raw FROM PROGRAM 'gunzip -c data/imdb/name.basics.tsv.gz'
WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', HEADER true, NULL '\N');

INSERT INTO name_basics
SELECT
    nconst,
    primary_name,
    birth_year::INTEGER,
    death_year::INTEGER,
    string_to_array(primary_profession, ','),
    string_to_array(known_for_titles, ',')
FROM name_basics_raw;

DROP TABLE name_basics_raw;

-- ==================================================
-- Done
-- ==================================================
