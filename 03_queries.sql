-- Show all events
SELECT * FROM security_events;

-- Show high severity events
SELECT * FROM security_events
WHERE severity = 'high';

-- Count events per IP
SELECT source_ip, COUNT(*) AS attack_count
FROM security_events
GROUP BY source_ip
ORDER BY attack_count DESC;

-- Count event types
SELECT event_type, COUNT(*) AS total
FROM security_events
GROUP BY event_type
ORDER BY total DESC;

-- Show latest events
SELECT * FROM security_events
ORDER BY event_time DESC;

-- High severity sorted by time
SELECT * FROM security_events
WHERE severity = 'high'
ORDER BY event_time DESC;
