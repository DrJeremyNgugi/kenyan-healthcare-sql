-- ─────────────────────────────────────────────────────────────────────
-- Mirai SQL Practice Queries
-- ─────────────────────────────────────────────────────────────────────
-- Purpose : SQL learning exercises against a Kenyan hospital data model.
-- Source  : Jose Portilla's SQL Bootcamp (Udemy) + Mirai Analytics domain.
-- Status  : Learning artifacts, not production code.
--
-- Schema assumed (matches the Mirai Analytics Pydantic models):
--
-- patients (
--     patient_id           VARCHAR PRIMARY KEY,
--     national_id          VARCHAR,         -- 7-8 digits, nullable
--     first_name           VARCHAR NOT NULL,
--     last_name            VARCHAR NOT NULL,
--     date_of_birth        DATE NOT NULL,
--     sex                  VARCHAR NOT NULL, -- male/female/other
--     phone_number         VARCHAR           -- +254 E.164, nullable
-- )
--
-- encounters (
--     encounter_id            VARCHAR PRIMARY KEY,
--     patient_id              VARCHAR NOT NULL REFERENCES patients,
--     encounter_type          VARCHAR NOT NULL, -- outpatient/inpatient/day_case/emergency
--     admission_date          DATE NOT NULL,
--     discharge_date          DATE,            -- nullable while admitted
--     ward                    VARCHAR,
--     attending_clinician_id  VARCHAR,
--     primary_diagnosis_code  VARCHAR           -- ICD-10 format
-- )
--
-- claims (
--     claim_id                VARCHAR PRIMARY KEY,
--     encounter_id            VARCHAR NOT NULL REFERENCES encounters,
--     patient_id              VARCHAR NOT NULL REFERENCES patients,
--     payer                   VARCHAR NOT NULL, -- SHA/Jubilee/AAR/etc
--     total_amount_kes        NUMERIC(12,2) NOT NULL,
--     submission_date         DATE NOT NULL,
--     status                  VARCHAR NOT NULL,
--     rejection_reason_code   VARCHAR,
--     paid_amount_kes         NUMERIC(12,2)
-- )
-- ─────────────────────────────────────────────────────────────────────

-- ─────────────────────────────────────────────────────────────────────
-- Section 1: SELECT and WHERE
-- ─────────────────────────────────────────────────────────────────────

-- 1.1 List all patients with their basic identifying info
SELECT patient_id, first_name, last_name, date_of_birth, sex
FROM patients;

-- 1.2 List only female patients
SELECT patient_id, first_name, last_name
FROM patients
WHERE sex = 'female';

-- 1.3 List patients without a national_id (children, foreigners, missing data)
SELECT patient_id, first_name, last_name, date_of_birth
FROM patients
WHERE national_id IS NULL;

