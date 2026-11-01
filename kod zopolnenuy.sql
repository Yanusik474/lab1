-- ============================================================
-- Test data: mail_types
-- ============================================================
INSERT INTO "mail_types"
("mail_type_name", "packaging",
 "min_weight_g", "max_weight_g",
 "min_length_mm", "min_width_mm", "min_height_mm",
 "max_length_mm", "max_width_mm", "max_height_mm")
VALUES
('Letter',            'Envelope',        1,   100, 100, 50,  1, 353, 250,   5),
('Parcel wrapper',    'Bag',             1,  2000, 100, 50,  1, 450, 350,  80),
('Parcel',            'Box',           100, 10000, 100, 50, 10, 600, 500, 400),
('Registered letter', 'Envelope',        1,   100, 100, 50,  1, 353, 250,   5),
('Insured wrapper',   'Reinforced bag',  1,  2000, 100, 50,  1, 450, 350,  80);

-- ============================================================
-- Test data: mailing_costs
-- ============================================================
INSERT INTO "mailing_costs"
("mail_type_code", "distance",
 "price_per_gram", "packaging_price",
 "urgency_surcharge", "declared_value_allowed")
VALUES
(1, 'up to 100 km',         0.0250,  15.00,  40.00, FALSE),
(1, '100 to 1000 km',       0.0350,  15.00,  50.00, FALSE),
(1, 'over 1000 km',         0.0450,  15.00,  60.00, FALSE),
(2, 'up to 100 km',         0.0400,  25.00,  60.00, FALSE),
(2, '100 to 1000 km',       0.0550,  25.00,  70.00, FALSE),
(3, 'up to 100 km',         0.0200,  50.00,  90.00, TRUE),
(3, '100 to 1000 km',       0.0300,  50.00, 110.00, TRUE),
(4, 'up to 100 km',         0.0300,  20.00,  55.00, FALSE),
(5, 'up to 100 km',         0.0450,  35.00,  80.00, TRUE);