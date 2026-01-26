CREATE TABLE title_akas (
    title_id TEXT NOT NULL,
    ordering INTEGER NOT NULL,
    title TEXT,
    region TEXT,
    language TEXT,
    types TEXT[],
    attributes TEXT[],
    is_original_title BOOLEAN,
    PRIMARY KEY (title_id, ordering)
);

CREATE TABLE title_basics (
    tconst TEXT PRIMARY KEY,
    title_type TEXT,
    primary_title TEXT,
    original_title TEXT,
    is_adult BOOLEAN,
    start_year INTEGER,
    end_year INTEGER,
    runtime_minutes INTEGER,
    genres TEXT[]
);

CREATE TABLE title_crew (
    tconst TEXT PRIMARY KEY,
    directors TEXT[],
    writers TEXT[]
);

CREATE TABLE title_episode (
    tconst TEXT PRIMARY KEY,
    parent_tconst TEXT,
    season_number INTEGER,
    episode_number INTEGER
);

CREATE TABLE title_principals (
    tconst TEXT NOT NULL,
    ordering INTEGER NOT NULL,
    nconst TEXT,
    category TEXT,
    job TEXT,
    characters TEXT,
    PRIMARY KEY (tconst, ordering)
);

CREATE TABLE title_ratings (
    tconst TEXT PRIMARY KEY,
    average_rating NUMERIC(3,1),
    num_votes INTEGER
);

CREATE TABLE name_basics (
    nconst TEXT PRIMARY KEY,
    primary_name TEXT,
    birth_year INTEGER,
    death_year INTEGER,
    primary_profession TEXT[],
    known_for_titles TEXT[]
);
