-- ============================================
-- EDA
-- ============================================

-- (Load Validation)
-- Does every fraud label maps to a real transaction?
SELECT fl.transaction_id
FROM fraud_labels fl
    LEFT JOIN transactions_data t 
    ON fl.transaction_id = t.id
WHERE t.id IS NULL;

-- (Page 1) 
-- What do zero-amount transactions actually look like? 
SELECT 
    amount, 
    COUNT(*) 
FROM vw_transactions_scoped 
WHERE amount = '$0.00'
GROUP BY amount;

-- (Page 1) 
-- Do zero-amount transactions cluster around specific channels, merchants, or categories?
SELECT 
    use_chip, 
    merchant_city, 
    mcc, 
    errors,
    amount,
    COUNT(*)
FROM vw_transactions_scoped
WHERE amount = '$0.00'
GROUP BY use_chip, merchant_city, mcc, errors,amount
ORDER BY COUNT(*) DESC;

-- (Page 1) 
-- Do refund/negative-amount transactions cluster around specific merchants or MCC categories?
SELECT 
    mcc, 
    use_chip, 
    COUNT(*), 
    MIN(amount), 
    MAX(amount)
FROM vw_transactions_scoped
WHERE amount LIKE '$-%'
GROUP BY mcc, use_chip
ORDER BY COUNT(*) DESC;

-- (Page 1) 
-- Does 'merchant_state' actually contain full country names mixed in with US state codes?
SELECT 
    merchant_state,
    LENGTH(merchant_state) AS value_length,
    COUNT(*) AS transaction_count
FROM vw_transactions_scoped
WHERE merchant_state IS NOT NULL
GROUP BY merchant_state
ORDER BY value_length ASC, transaction_count DESC;

-- (Page 2) 
-- Is fraud genuinely absent for Jan-Oct 2017, or just unlabeled?
SELECT 
    DATE_TRUNC('month', t.date) AS month,
    fl.is_fraud,
    COUNT(*) 
FROM vw_transactions_scoped t
JOIN vw_fraud_labels_scoped fl 
    ON t.id = fl.transaction_id
WHERE t.date < '2017-11-01'
GROUP BY 1, 2
ORDER BY 1, 2;

-- (Data Model Validation)
-- Does 'expires' parse correctly as a date, or is Power Query misreading the raw MM/YYYY format?
SELECT expires 
FROM cards_data 
WHERE id IN (0,1,2,6) 
ORDER BY id;

SELECT 
	id, 
	expires
FROM cards_data
WHERE expires IS NULL
   OR expires NOT LIKE '__/____'
   OR SUBSTRING(expires, 1, 2) NOT IN ('01','02','03','04','05','06','07','08','09','10','11','12');
  


