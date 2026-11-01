-- ============================================================
-- Drop tables if they already exist (for recreation)
-- ============================================================
DROP TABLE IF EXISTS "mailing_costs" CASCADE;
DROP TABLE IF EXISTS "mail_types" CASCADE;

-- ============================================================
-- Table "mail_types" (Виды корреспонденции)
-- ============================================================
CREATE TABLE "mail_types" (
    "mail_type_code"   SERIAL        PRIMARY KEY,
    "mail_type_name"   VARCHAR(100)  NOT NULL,
    "packaging"        VARCHAR(100)  NOT NULL,
    "min_weight_g"     NUMERIC(10,2) NOT NULL CHECK ("min_weight_g" >= 0),
    "max_weight_g"     NUMERIC(10,2) NOT NULL CHECK ("max_weight_g" > 0),
    "min_length_mm"    NUMERIC(10,2) NOT NULL CHECK ("min_length_mm" >= 0),
    "min_width_mm"     NUMERIC(10,2) NOT NULL CHECK ("min_width_mm" >= 0),
    "min_height_mm"    NUMERIC(10,2) NOT NULL CHECK ("min_height_mm" >= 0),
    "max_length_mm"    NUMERIC(10,2) NOT NULL CHECK ("max_length_mm" > 0),
    "max_width_mm"     NUMERIC(10,2) NOT NULL CHECK ("max_width_mm" > 0),
    "max_height_mm"    NUMERIC(10,2) NOT NULL CHECK ("max_height_mm" > 0),
    CONSTRAINT chk_weights CHECK ("max_weight_g"  >  "min_weight_g"),
    CONSTRAINT chk_lengths CHECK ("max_length_mm" >= "min_length_mm"),
    CONSTRAINT chk_widths  CHECK ("max_width_mm"  >= "min_width_mm"),
    CONSTRAINT chk_heights CHECK ("max_height_mm" >= "min_height_mm")
);

-- ============================================================
-- Table "mailing_costs" (Стоимости отправки)
-- Composite PK: mail type + distance
-- ============================================================
CREATE TABLE "mailing_costs" (
    "mail_type_code"        INTEGER       NOT NULL,
    "distance"              VARCHAR(50)   NOT NULL,
    "price_per_gram"        NUMERIC(10,4) NOT NULL CHECK ("price_per_gram" >= 0),
    "packaging_price"       NUMERIC(10,2) NOT NULL CHECK ("packaging_price" >= 0),
    "urgency_surcharge"     NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK ("urgency_surcharge" >= 0),
    "declared_value_allowed" BOOLEAN      NOT NULL DEFAULT FALSE,

    PRIMARY KEY ("mail_type_code", "distance"),
    CONSTRAINT fk_cost_mail_type
        FOREIGN KEY ("mail_type_code")
        REFERENCES "mail_types"("mail_type_code")
        ON UPDATE CASCADE
        ON DELETE CASCADE
);