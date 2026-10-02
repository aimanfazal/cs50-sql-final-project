INSERT INTO brands (name) VALUES ('Raw');
INSERT INTO brands 
(name) VALUES ('SmackDown');


INSERT INTO wrestlers (ring_name, real_name, height_cm, weight_kg, hometown, 
debut_date, status, brand_id)
VALUES ('Cody Rhodes', 'Cody Runnels', 191, 106, 'Marietta, Georgia', '2006-06-24', 'active', 1);

INSERT INTO wrestlers 
(ring_name, real_name, height_cm, weight_kg, hometown, debut_date, status, brand_id)
VALUES ('Roman Reigns', 'Leati Joseph Anoa''i', 191, 120, 'Pensacola, Florida', '2010-08-27', 'active', 1);

INSERT INTO championships (name, division, brand_id)
VALUES ('WWE Championship', 'mens', 1);
INSERT INTO title_reigns (wrestler_id, championship_id, won_date, lost_date)
VALUES (1, 1, '2024-04-07', NULL);

INSERT INTO events (name, date, venue, event_type)
VALUES ('WrestleMania 40', '2024-04-07', 'Lincoln Financial Field', 'ppv');

INSERT INTO matches 
(event_id, match_type, stipulation, card_order, wrestler1_id, wrestler2_id, winner_id, notes)
VALUES (1, 'singles', 'Undisputed WWE Championship', 1, 1, 2, 1, NULL);

SELECT ring_name, hometown, status
FROM wrestlers

WHERE brand_id = 1 AND status = 'active';
SELECT * FROM current_champions;

SELECT c.name AS championship, tr.won_date, tr.lost_date FROM title_reigns tr
JOIN championships c ON c.championship_id = tr.championship_id
WHERE tr.wrestler_id = 1
ORDER BY tr.won_date DESC;

SELECT
    c.name AS championship,
    w.ring_name AS champion,
    tr.won_date,
    COALESCE(tr.lost_date, CURDATE()) AS reign_end,
    DATEDIFF(COALESCE(tr.lost_date, CURDATE()), tr.won_date) AS reign_length_days
FROM title_reigns tr
JOIN wrestlers w ON w.wrestler_id = tr.wrestler_id
JOIN championships c ON c.championship_id = tr.championship_id
ORDER BY reign_length_days DESC
LIMIT 5;

SELECT
    w.ring_name,
    SUM(CASE WHEN m.winner_id = w.wrestler_id THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN m.winner_id IS NOT NULL AND m.winner_id != w.wrestler_id THEN 1 ELSE 0 END) AS losses
FROM wrestlers w
JOIN matches m ON w.wrestler_id IN (m.wrestler1_id, m.wrestler2_id)
WHERE w.wrestler_id = 1

GROUP BY w.wrestler_id, w.ring_name;

SELECT ch.name AS championship, ch.division
FROM championships ch

JOIN brands b ON b.brand_id = ch.brand_id
WHERE b.name = 'Raw';

UPDATE wrestlers
SET brand_id = 2
WHERE wrestler_id = 1;

UPDATE title_reigns
SET lost_date = '2024-08-03'
WHERE wrestler_id = 1 AND championship_id = 1 AND lost_date IS NULL;

UPDATE wrestlers

SET status = 'retired'
WHERE wrestler_id = 1;

INSERT INTO wrestlers (ring_name, real_name, brand_id)
VALUES ('Jobber McNoDeps', 'John Doe', 1);
DELETE FROM wrestlers
WHERE ring_name = 'Jobber McNoDeps';