-- ============================================
-- Adding PKs, FKs, and indexes after bulk load
-- ============================================

-- Primary Keys
ALTER TABLE users_data ADD CONSTRAINT pk_users_data PRIMARY KEY (id);
ALTER TABLE cards_data ADD CONSTRAINT pk_cards_data PRIMARY KEY (id);
ALTER TABLE mcc_codes ADD CONSTRAINT pk_mcc_codes PRIMARY KEY (mcc_code);
ALTER TABLE transactions_data ADD CONSTRAINT pk_transactions_data PRIMARY KEY (id);
ALTER TABLE fraud_labels ADD CONSTRAINT pk_fraud_labels PRIMARY KEY (transaction_id);

-- Foreign Keys
ALTER TABLE cards_data ADD CONSTRAINT fk_cards_client FOREIGN KEY (client_id) REFERENCES users_data(id);
ALTER TABLE transactions_data ADD CONSTRAINT fk_transactions_client FOREIGN KEY (client_id) REFERENCES users_data(id);
ALTER TABLE transactions_data ADD CONSTRAINT fk_transactions_card FOREIGN KEY (card_id) REFERENCES cards_data(id);
ALTER TABLE transactions_data ADD CONSTRAINT fk_transactions_mcc FOREIGN KEY (mcc) REFERENCES mcc_codes(mcc_code);
ALTER TABLE fraud_labels ADD CONSTRAINT fk_fraud_transaction FOREIGN KEY (transaction_id) REFERENCES transactions_data(id);

-- Indexes 
CREATE INDEX idx_transactions_date ON transactions_data(date);
CREATE INDEX idx_transactions_client ON transactions_data(client_id);
CREATE INDEX idx_transactions_card ON transactions_data(card_id);
CREATE INDEX idx_fraud_transaction ON fraud_labels(transaction_id);