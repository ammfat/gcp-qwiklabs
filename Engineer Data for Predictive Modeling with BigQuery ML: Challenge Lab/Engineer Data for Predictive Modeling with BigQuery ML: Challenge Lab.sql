-- Engineer Data for Predictive Modeling with BigQuery ML: Challenge Lab
-- Challenge scenario
-- You have started a new role as a Data Engineer for TaxiCab Inc. You are expected to import some historical data to a working BigQuery dataset, and build a basic model that predicts fares based on information available when a new ride starts. Leadership is interested in building an app and estimating for users how much a ride will cost. The source data will be provided in your project.

-- You are expected to have the skills and knowledge for these tasks, so don't expect step-by-step guides to be provided.

-- Your challenge
-- As soon as you sit down at your desk and open your new laptop you receive your first assignment: build a basic BQML fare prediction model for leadership. Perform the following tasks to import and clean the data, then build the model and perform batch predictions with new data so that leadership can review model performance and make a go/no-go decision on deploying the app functionality.

-- Task 1. Clean your training data
-- You've already completed the first step, and have created a dataset taxirides and imported the historical data to table, historical_taxi_rides_raw. This is data prior for rides to 2015.

-- Note: You may need to wait 1-3 minutes for the data to be fully populated in your project.
-- To complete this task you will need to:

-- Clean the data in historical_taxi_rides_raw and make a copy to taxi_training_data_434 in the same dataset. You can use BigQuery, Dataprep, Dataflow, etc. to create this table and clean the data. Make sure your target column is called fare_amount_403.
-- Some helpful hints:

-- You can see the source dataset in the BQ UI - familiarize yourself with the source schema first.
-- As a hint for the data available at prediction time, familiarize yourself with the table taxirides.report_prediction_data which shows the format data will arrive at prediction time.
-- Data cleaning tasks:

-- Ensure trip_distance is greater than 2.
-- Remove rows where fare_amount is very small (less than $2.5 for example).
-- Ensure that the latitudes and longitudes are reasonable for the use case.
-- Ensure passenger_count is greater than 2.
-- Be sure to add tolls_amount and fare_amount to fare_amount_403 as the target variable since total_amount includes tips.
-- Because the source dataset is large (>1 Billion rows), sample the dataset to less than 1 Million rows.
-- Only copy fields that will be used in your model (report_prediction_data is a good guide).

-- Click Check my progress to verify the objective.
-- [ ] Create a cleaned copy of the data in taxi_training_data_434

CREATE OR REPLACE TABLE `taxirides.taxi_training_data_434`
AS 
SELECT
  (tolls_amount + fare_amount) AS fare_amount_403
  , pickup_datetime
  , pickup_longitude AS pickuplon
  , pickup_latitude AS pickuplat
  , dropoff_longitude AS dropofflon
  , dropoff_latitude AS dropofflat
  , passenger_count AS passengers
FROM
  taxirides.historical_taxi_rides_raw
WHERE 1=1
  AND RAND() < 0.001
  AND trip_distance > 2
  AND fare_amount >= 2.5
  AND pickup_longitude > -78
  AND pickup_longitude < -70
  AND dropoff_longitude > -78
  AND dropoff_longitude < -70
  AND pickup_latitude > 37
  AND pickup_latitude < 45
  AND dropoff_latitude > 37
  AND dropoff_latitude < 45
  AND passenger_count > 2
;

-- Task 2. Create a BigQuery ML model
-- Based on the data you have in taxirides.taxi_training_data_434, build a BigQuery ML model that predicts fare_amount_403.

-- Call the model taxirides.fare_model_333.

-- Note: Your model will need an RMSE of 10 or less to complete the task.
-- Some helpful hints:

-- You can encapsulate any additional data transformations in a TRANSFORM() clause
-- Keep in mind, only features in the TRANSFORM() clause will be passed to the model. You can use a * EXCEPT(feature_to_leave_out) to pass some or all of the features without explicitly calling them
-- ST_distance() and ST_GeogPoint() GIS functions in BigQuery can be used to easily calculate euclidean distance (i.e. how far pickup to dropoff did the taxi travel):
-- ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean
-- Copied!
-- Click Check my progress to verify the objective.
-- Create BigQuery ML model fare_model_333 with RMSE 10 or less

CREATE OR REPLACE MODEL `taxirides.fare_model_333`
TRANSFORM(
  * EXCEPT (pickup_datetime)
  , ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean
  -- , CAST(EXTRACT(DAYOFWEEK FROM pickup_datetime) AS STRING) AS dayofweek
  -- , CAST(EXTRACT(HOUR FROM pickup_datetime) AS STRING) AS hourofday
)
OPTIONS(
  model_type='linear_reg', 
  input_label_cols=['fare_amount_403']
)
AS 
SELECT * 
FROM `taxirides.taxi_training_data_434`
;

SELECT
  SQRT(mean_squared_error) AS rmse,
  *
FROM ML.EVALUATE(
  MODEL `taxirides.fare_model_333`,
  (
    SELECT *
    FROM `taxirides.taxi_training_data_434`
  )
);

CREATE OR REPLACE MODEL `taxirides.fare_model_333_2`
TRANSFORM(
  * EXCEPT (pickup_datetime)
  , ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean
  , CAST(EXTRACT(DAYOFWEEK FROM pickup_datetime) AS STRING) AS dayofweek
  , CAST(EXTRACT(HOUR FROM pickup_datetime) AS STRING) AS hourofday
)
OPTIONS(
  model_type='linear_reg', 
  input_label_cols=['fare_amount_403']
)
AS 
SELECT * 
FROM `taxirides.taxi_training_data_434`
;

SELECT
  SQRT(mean_squared_error) AS rmse,
  *
FROM ML.EVALUATE(
  MODEL `taxirides.fare_model_333_2`,
  (
    SELECT *
    FROM `taxirides.taxi_training_data_434`
  )
);

-- Task 3. Perform a batch prediction on new data
-- Leadership is curious to see how well your model performs over new data, in this case, all of the data they've collected in 2015. This data is in taxirides.report_prediction_data. Only values known at prediction time are included in the table.

-- Use ML.PREDICT and your model to predict fare_amount_403 and store your results in a table called 2015_fare_amount_predictions.
-- Click Check my progress to verify the objective.
-- Perform batch predictions and store in a new table 2015_fare_amount_predictions

SELECT
  predicted_fare_amount_403
  , ABS(predicted_fare_amount_403) AS absolute_predicted_fare_amount_403
  , * EXCEPT(predicted_fare_amount_403)
FROM
  ML.PREDICT(
    MODEL `taxirides.fare_model_333`,
    (
      SELECT *
      FROM `taxirides.report_prediction_data`
    )
  );

CREATE OR REPLACE TABLE `taxirides.2015_fare_amount_predictions` AS
SELECT
  -- predicted_fare_amount_403
  *
FROM
  ML.PREDICT(
    MODEL `taxirides.fare_model_333`,
    (
      SELECT *
      FROM `taxirides.report_prediction_data`
    )
  );
