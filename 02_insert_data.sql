-- Insert sample security data
INSERT INTO security_events (event_time, event_type, source_ip, severity, description)
VALUES
('2026-03-27 10:15:00', 'failed_login', '192.168.1.50', 'medium', 'Multiple failed SSH login attempts detected'),
('2026-03-27 11:00:00', 'port_scan', '10.0.0.23', 'high', 'Port scan detected against internal web server'),
('2026-03-27 11:30:00', 'malware_alert', '172.16.0.15', 'high', 'Endpoint protection flagged suspicious file activity');
