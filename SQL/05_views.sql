-- ============================================
-- Creating Views
-- Window: 2017-01-01 to 2018-12-31 (2 full years)
-- ============================================

-- 1. Transactions scoped view
DROP VIEW IF EXISTS vw_transactions_scoped;

CREATE VIEW vw_transactions_scoped AS
	SELECT
	    id,
	    date,
	    client_id,
	    card_id,
	    amount,
	    use_chip,
	    merchant_id,
	    merchant_city,
	    merchant_state,
	    zip,
	    mcc,
	    errors
	FROM transactions_data
	WHERE date >= '2017-01-01' AND date < '2019-01-01';

-- 2. Fraud labels scoped view
DROP VIEW IF EXISTS vw_fraud_labels_scoped;

CREATE VIEW vw_fraud_labels_scoped AS
	SELECT
	    fl.transaction_id, 
	    fl.is_fraud
	FROM fraud_labels fl
	INNER JOIN vw_transactions_scoped t
	    ON fl.transaction_id = t.id;


-- 3. Sanity checks on views
SELECT COUNT(*) FROM vw_transactions_scoped;
SELECT COUNT(*) FROM vw_fraud_labels_scoped;

SELECT MIN(date), MAX(date) FROM vw_transactions_scoped;

		