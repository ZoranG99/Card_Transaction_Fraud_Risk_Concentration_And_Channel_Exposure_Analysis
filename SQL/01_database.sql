--=============================
-- Creating the database
--=============================

-- Creating the empty database
DROP DATABASE IF EXISTS sentinel_fraud_risk;
CREATE DATABASE sentinel_fraud_risk;


-- Raw-matching schema — NO constraints at creation.
-- PKs, FKs, and indexes added after bulk load (03_constraints.sql)


-- Dropping all tables (if they exists)
DROP TABLE IF EXISTS fraud_labels;
DROP TABLE IF EXISTS transactions_data;
DROP TABLE IF EXISTS mcc_codes;
DROP TABLE IF EXISTS cards_data;
DROP TABLE IF EXISTS users_data;

-- 1. Creating table users_data
CREATE TABLE users_data (
    id INT,
    current_age INT,
    retirement_age INT,
    birth_year INT,
    birth_month INT,
    gender TEXT,
    address TEXT,
    latitude FLOAT,
    longitude FLOAT,
    per_capita_income TEXT,
    yearly_income TEXT,
    total_debt TEXT,
    credit_score INT,
    num_credit_cards INT
);

-- 2. Creating table cards_data
CREATE TABLE cards_data (
    id INT,
    client_id INT,
    card_brand TEXT,
    card_type TEXT,
    card_number TEXT,
    expires TEXT,
    cvv TEXT,
    has_chip TEXT,
    num_cards_issued INT,
    credit_limit TEXT,
    acct_open_date TEXT,
    year_pin_last_changed INT,
    card_on_dark_web TEXT
);

-- 3. Creating table mcc_codes
CREATE TABLE mcc_codes (
    mcc_code INT,
    description TEXT
);

-- 4. Creating table transactions_data
CREATE TABLE transactions_data (
    id INT,
    date TIMESTAMP,
    client_id INT,
    card_id INT,
    amount TEXT,
    use_chip TEXT,
    merchant_id INT,
    merchant_city TEXT,
    merchant_state TEXT,
    zip TEXT,
    mcc INT,
    errors TEXT
);

-- 5. Creating table fraud_labels
CREATE TABLE fraud_labels (
    transaction_id INT,
    is_fraud TEXT
);


