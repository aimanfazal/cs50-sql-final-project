CREATE TABLE brands (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE wrestlers (
    wrestler_id INT PRIMARY KEY AUTO_INCREMENT,
    ring_name VARCHAR(100) NOT NULL,
    real_name VARCHAR(150),
    height_cm INT,
    weight_kg INT,
    hometown VARCHAR(150),
    debut_date DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    brand_id INT,
    FOREIGN KEY (brand_id) REFERENCES brands (brand_id),
    CHECK (
        status IN ('active','injured','released','retired'
        )
    )
);
CREATE TABLE championships (
    championship_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL UNIQUE,
    division VARCHAR(20) NOT NULL,
    brand_id INT,
    FOREIGN KEY (brand_id) REFERENCES brands (brand_id),
    CHECK (
        division IN ('mens', 'womens', 'tag_team')
    )
);

CREATE TABLE title_reigns (
    reign_id INT PRIMARY KEY AUTO_INCREMENT,
    wrestler_id INT NOT NULL,
    championship_id INT NOT NULL,
    won_date DATE NOT NULL,
    lost_date DATE,
    FOREIGN KEY (wrestler_id) REFERENCES wrestlers (wrestler_id),
    FOREIGN KEY (championship_id) REFERENCES championships (championship_id),
    CHECK (
        lost_date IS NULL OR lost_date >= won_date
    )
);


CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    date DATE NOT NULL,
    venue VARCHAR(200),
    event_type VARCHAR(20) NOT NULL,
    CHECK (
        event_type IN ('ppv', 'weekly')
    )
);
CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    match_type VARCHAR(100) NOT NULL,
    stipulation VARCHAR(200),
    card_order INT,
    wrestler1_id INT NOT NULL,
    wrestler2_id INT,
    winner_id INT,
    notes TEXT,
    FOREIGN KEY (event_id) REFERENCES events (event_id),
    FOREIGN KEY (wrestler1_id) REFERENCES wrestlers (wrestler_id),
    FOREIGN KEY (wrestler2_id) REFERENCES wrestlers (wrestler_id),
    FOREIGN KEY (winner_id) REFERENCES wrestlers (wrestler_id)
);

CREATE INDEX idx_brand ON wrestlers (brand_id);

CREATE INDEX idx_ring_name ON wrestlers (ring_name);
CREATE INDEX idx_title_reigns ON title_reigns (wrestler_id);

CREATE INDEX idx_championship ON title_reigns (championship_id);

CREATE VIEW current_champions AS
SELECT c.name AS championship, w.ring_name AS champion, tr.won_date
FROM title_reigns tr
JOIN wrestlers w ON w.wrestler_id = tr.wrestler_id
JOIN championships c ON c.championship_id = tr.championship_id
WHERE tr.lost_date IS NULL;