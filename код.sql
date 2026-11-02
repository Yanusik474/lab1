DROP TABLE IF EXISTS "mailing_costs" CASCADE;
DROP TABLE IF EXISTS "mail_types" CASCADE;

CREATE TABLE "mail_types" (
    "mail_type_code"   SERIAL PRIMARY KEY,
    "mail_type_name"   VARCHAR(100) NOT NULL,
    "packaging"        VARCHAR(100) NOT NULL,
    "min_weight_g"     NUMERIC(10,2) NOT NULL,
    "max_weight_g"     NUMERIC(10,2) NOT NULL,
    "min_length_mm"    NUMERIC(10,2) NOT NULL,
    "min_width_mm"     NUMERIC(10,2) NOT NULL,
    "min_height_mm"    NUMERIC(10,2) NOT NULL,
    "max_length_mm"    NUMERIC(10,2) NOT NULL,
    "max_width_mm"     NUMERIC(10,2) NOT NULL,
    "max_height_mm"    NUMERIC(10,2) NOT NULL,
    CONSTRAINT chk_weights CHECK ("max_weight_g" > "min_weight_g"),
    CONSTRAINT chk_lengths CHECK ("max_length_mm" >= "min_length_mm"),
    CONSTRAINT chk_widths  CHECK ("max_width_mm" >= "min_width_mm"),
    CONSTRAINT chk_heights CHECK ("max_height_mm" >= "min_height_mm")
);

CREATE TABLE "mailing_costs" (
    "mail_type_code"         INTEGER NOT NULL,
    "distance"               VARCHAR(50) NOT NULL,
    "price_per_gram"         NUMERIC(10,4) NOT NULL,
    "packaging_price"        NUMERIC(10,2) NOT NULL,
    "urgency_surcharge"      NUMERIC(10,2) NOT NULL DEFAULT 0,
    "declared_value_allowed" BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY ("mail_type_code", "distance"),
    CONSTRAINT fk_cost_mail_type 
        FOREIGN KEY ("mail_type_code") 
        REFERENCES "mail_types" ("mail_type_code")
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

INSERT INTO "mail_types" 
("mail_type_name", "packaging", "min_weight_g", "max_weight_g", "min_length_mm", "min_width_mm", "min_height_mm", "max_length_mm", "max_width_mm", "max_height_mm")
VALUES
('Letter',            'Envelope',        1,   100,   100,  50,   1,  353, 250,   5),
('Registered Letter', 'Envelope',        1,   100,   100,  50,   1,  353, 250,   5),
('Valuable Letter',   'Envelope',        1,   100,   100,  50,   1,  353, 250,   5),
('Parcel Wrapper',    'Bag',             1,  2000,   100,  50,   1,  450, 350,  80),
('Insured Wrapper',   'Reinforced Bag',  1,  2000,   100,  50,   1,  450, 350,  80),
('Small Parcel',      'Box',           100,  2000,   100,  50,  10,  300, 200, 150),
('Standard Parcel',   'Box',           100,  5000,   100,  50,  10,  450, 350, 250),
('Large Parcel',      'Box',           100, 10000,   100,  50,  10,  600, 500, 400),
('Express Post',      'Box',             1,  5000,   150, 100,  10,  400, 300, 200),
('International Post','Reinforced Box',  1, 20000,   150, 100,  10,  800, 600, 500);

INSERT INTO "mailing_costs" 
("mail_type_code", "distance", "price_per_gram", "packaging_price", "urgency_surcharge", "declared_value_allowed")
VALUES
(1, 'Up to 100 km',         0.0250,  15.00,  40.00, FALSE),
(1, '100 to 1000 km',       0.0350,  15.00,  50.00, FALSE),
(2, 'Up to 100 km',         0.0300,  20.00,  55.00, FALSE),
(3, 'Up to 100 km',         0.0450,  35.00,  80.00, TRUE),
(4, 'Up to 100 km',         0.0400,  25.00,  60.00, FALSE),
(4, '100 to 1000 km',       0.0550,  25.00,  70.00, FALSE),
(5, '100 to 1000 km',       0.0650,  45.00,  90.00, TRUE),
(6, 'Up to 100 km',         0.0200,  40.00,  85.00, FALSE),
(7, 'Up to 100 km',         0.0250,  50.00,  95.00, TRUE),
(8, 'Over 1000 km',         0.0300,  60.00, 110.00, TRUE),
(9, 'Over 1000 km',         0.0800,  70.00, 150.00, TRUE),
(10,'International',        0.1000, 100.00, 200.00, TRUE);