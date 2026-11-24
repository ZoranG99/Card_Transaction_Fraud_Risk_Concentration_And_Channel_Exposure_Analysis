--=============================
-- Loading the data
--=============================

-- 1. Loading users_data table
COPY users_data
FROM 'D:\Data_Science\Projects\Portfolio_Projects\Card_Transaction_Fraud_Risk_Concentration_And_Channel_Exposure_Analysis\Dataset\Raw\users_data.csv'
DELIMITER ',' CSV HEADER;

-- 2. Loading cards_data table
COPY cards_data
FROM 'D:\Data_Science\Projects\Portfolio_Projects\Card_Transaction_Fraud_Risk_Concentration_And_Channel_Exposure_Analysis\Dataset\Raw\cards_data.csv'
DELIMITER ',' CSV HEADER;

-- 3. Loading mcc_codes table
COPY mcc_codes
FROM 'D:\Data_Science\Projects\Portfolio_Projects\Card_Transaction_Fraud_Risk_Concentration_And_Channel_Exposure_Analysis\Dataset\Raw\mcc_codes.csv'
DELIMITER ',' CSV HEADER;

-- 4. Loading transactions_data table
COPY transactions_data
FROM 'D:\Data_Science\Projects\Portfolio_Projects\Card_Transaction_Fraud_Risk_Concentration_And_Channel_Exposure_Analysis\Dataset\Raw\transactions_data.csv'
DELIMITER ',' CSV HEADER;

-- 5. Loading fraud_labels table
COPY fraud_labels
FROM 'D:\Data_Science\Projects\Portfolio_Projects\Card_Transaction_Fraud_Risk_Concentration_And_Channel_Exposure_Analysis\Dataset\Raw\fraud_labels.csv'
DELIMITER ',' CSV HEADER;

