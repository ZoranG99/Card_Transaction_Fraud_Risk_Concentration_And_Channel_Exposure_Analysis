-- ============================================
-- Sanity Check
-- ============================================

-- 1. Row counts
SELECT 'users_data' AS table_name, COUNT(*) AS row_count FROM users_data
UNION ALL
SELECT 'cards_data', COUNT(*) FROM cards_data
UNION ALL
SELECT 'mcc_codes', COUNT(*) FROM mcc_codes
UNION ALL
SELECT 'transactions_data', COUNT(*) FROM transactions_data
UNION ALL
SELECT 'fraud_labels', COUNT(*) FROM fraud_labels;

-- 2. Column counts
SELECT
    table_name,
    COUNT(*) AS column_count
FROM information_schema.columns
WHERE table_schema = 'public'
	AND table_name IN ('users_data', 'cards_data', 'mcc_codes', 'transactions_data', 'fraud_labels')
GROUP BY table_name
ORDER BY table_name;

-- 3. Spot-check 
SELECT * FROM users_data LIMIT 5;
SELECT * FROM transactions_data LIMIT 5;

-- 4. Date range check 
SELECT 
	MIN(date) AS min_date, 
	MAX(date) AS max_date
FROM transactions_data;

-- 5. Fraud rate check (should match: ~0.15%)
SELECT
    is_fraud,
    COUNT(*) AS n,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 3) AS pct
FROM fraud_labels
GROUP BY is_fraud;

-- 6. Fraud label coverage (should match: ~67% of transactions have a label)
SELECT
    COUNT(t.id) AS total_transactions,
    COUNT(f.transaction_id) AS labeled_transactions,
    ROUND(100.0 * COUNT(f.transaction_id) / COUNT(t.id), 2) AS pct_labeled
FROM transactions_data t
LEFT JOIN fraud_labels f 
	ON t.id = f.transaction_id;


