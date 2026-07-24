-- Build a Data Warehouse with BigQuery: Challenge Lab
-- Challenge scenario
-- You are part of an international public health organization which is tasked with developing a machine learning model to predict the daily case count for countries during the Covid-19 pandemic. As a junior member of the Data Science team you've been assigned to use your data warehousing skills to develop a table containing the features for the machine learning model.

-- You are expected to have the skills and knowledge for this task, so don't expect step-by-step guides to be provided.

-- TASK 1

-- Create a table partitioned by date
-- The starting point for the machine learning model will be the oxford_policy_tracker table in the COVID 19 Government Response public dataset which contains details of different actions taken by governments to curb the spread of Covid-19 in their jurisdictions.

-- Given the fact that there will be models based on a range of time periods, you have to create a dataset and then create a date partitioned version of the oxford_policy_tracker table in your newly created dataset, with an expiry time set to 2175 days.

-- While creating a table, you have also been instructed to exclude the United Kingdom ( alpha_3_code=GBR), Brazil ( alpha_3_code=BRA), Canada ( alpha_3_code=CAN) & the United States of America (alpha_3_code=USA) as these will be subject to more in-depth analysis through nation and state specific analysis.

-- Create a new dataset covid and create a table oxford_policy_tracker in that dataset partitioned by date, with an expiry of 2175 days. The table should initially use the schema defined for the oxford_policy_tracker table in the COVID 19 Government Response public dataset .
-- You must also populate the table with the data from the source table for all countries and exclude the United Kingdom (GBR), Brazil (BRA), Canada (CAN) and the United States (USA) as instructed above.

-- SHOW CREATE TABLE bigquery-public-data.covid19_govt_response.oxford_policy_tracker;

-- SELECT ddl 
-- FROM `bigquery-public-data.covid19_govt_response.INFORMATION_SCHEMA.TABLES`
-- WHERE table_name = 'oxford_policy_tracker';

-- CREATE TABLE `qwiklabs-gcp-03-f29811fba497.covid.oxford_policy_tracker`
-- (
--   country_name STRING OPTIONS(description="Name of the country"),
--   alpha_3_code STRING OPTIONS(description="3-letter alpha code abbreviation of the country/region. See `bigquery-public-data.utility_us.country_code_iso` for more details"),
--   region_name STRING OPTIONS(description="Name of the region within the country"),
--   region_code STRING OPTIONS(description="Code of the region within the country"),
--   date DATE OPTIONS(description="Date of the measured policy action status"),
--   school_closing STRING OPTIONS(description="C1 - Ordinal scale record closings of schools and universities; 0 - No measures 1 - recommend closing 2 - Require closing (only some levels or categories eg just high school or just public schools) 3 - Require closing all levels No data - blank"),
--   school_closing_flag STRING OPTIONS(description="Are C1 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   school_closing_notes STRING OPTIONS(description="Additional details about C1 policy actions"),
--   workplace_closing STRING OPTIONS(description="C2 - Ordinal scale record closings of workplace; 0 - No measures 1 - recommend closing (or work from home) 2 - require closing (or work from home) for some sectors or categories of workers 3 - require closing (or work from home) all-but-essential workplaces (eg grocery stores doctors) No data - blank"),
--   workplace_closing_flag STRING OPTIONS(description="Are C2 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   workplace_closing_notes STRING OPTIONS(description="Additional details about C2 policy actions"),
--   cancel_public_events STRING OPTIONS(description="C3 - Ordinal scale record cancellations of public events;0- No measures 1 - Recommend cancelling 2 - Require cancelling No data - blank"),
--   cancel_public_events_flag STRING OPTIONS(description="Are C3 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   cancel_public_events_notes STRING OPTIONS(description="Additional details about C3 policy actions"),
--   restrictions_on_gatherings STRING OPTIONS(description="C4 - Ordinal scale to record the cut-off size for bans on private gatherings;  0 - No restrictions 1 - Restrictions on very large gatherings (the limit is above 1000 people) 2 - Restrictions on gatherings between 100-1000 people 3 - Restrictions on gatherings between 10-100 people 4 - Restrictions on gatherings of less than 10 people No data - blank"),
--   restrictions_on_gatherings_flag STRING OPTIONS(description="Are C4 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   restrictions_on_gatherings_notes STRING OPTIONS(description="Additional details about C4 policy actions"),
--   close_public_transit STRING OPTIONS(description="C5 - Ordinal scale to record closing of public transportation; 0 - No measures 1 - Recommend closing (or significantly reduce volume/route/means of transport available) 2 - Require closing (or prohibit most citizens from using it)"),
--   close_public_transit_flag STRING OPTIONS(description="Are C5 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   close_public_transit_notes STRING OPTIONS(description="Additional details about C5 policy actions"),
--   stay_at_home_requirements STRING OPTIONS(description="C6 - Ordinal scale record of orders to “shelter-in- place” and otherwise confine to home."),
--   stay_at_home_requirements_flag STRING OPTIONS(description="Are C6 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank\"\\"),
--   stay_at_home_requirements_notes STRING OPTIONS(description="Additional details about C6 policy actions"),
--   restrictions_on_internal_movement STRING OPTIONS(description="C7 - Ordinal scale of restrictions on internal movement;  0 - No measures 1 - Recommend closing (or significantly reduce volume/route/means of transport) 2 - Require closing (or prohibit most people from using it)"),
--   restrictions_on_internal_movement_flag STRING OPTIONS(description="Are C7 actions targeted at specific areas or general:0 - Targeted 1- General No data - blank"),
--   restrictions_on_internal_movement_notes STRING OPTIONS(description="Additional details about C7 policy actions"),
--   international_travel_controls STRING OPTIONS(description="C8 - Ordinal scale record of restrictions oternational travel; 0 - No measures 1 - Screening 2 - Quarantine arrivals from high-risk regions 3 - Ban on high-risk regions 4 - Total border closure No data - blank"),
--   international_travel_controls_notes STRING OPTIONS(description="Additional details about C8 policy actions"),
--   income_support STRING OPTIONS(description="E1 - Ordinal scale record if the government is covering the salaries or providing direct cash payments universal basic income or similar of people who lose their jobs or cannot work. (Includes payments to firms if explicitly linked to payroll/ salaries)"),
--   income_support_flag STRING OPTIONS(description="Sector scope of E1 actions;  0 - formal sector workers only 1 - transfers to informal sector workers too No data - blank"),
--   income_support_notes STRING OPTIONS(description="Additional details about E1 policy actions"),
--   debt_contract_relief STRING OPTIONS(description="E2 - Record if govt. is freezing financial obligations (eg stopping loan repayments preventing services like water from stopping or banning evictions)"),
--   debt_contract_relief_notes STRING OPTIONS(description="Additional details about E2 policy actions"),
--   fiscal_measures FLOAT64 OPTIONS(description="E3 - What economic stimulus policies are adopted (in USD); Record monetary value USD of fiscal stimuli including spending or tax cuts NOT included in S10 (see below) -If none enter 0 No data - blank Please use the exchange rate of the date you are coding not the current date."),
--   fiscal_measures_notes STRING OPTIONS(description="Additional details about E3 policy actions"),
--   international_support FLOAT64 OPTIONS(description="E4 - Announced offers of COVID-19 related aid spending to other countries (in USD);  Record monetary value announced if additional to previously announced spending -if none enter 0 No data - blank Please use the exchange rate of the date you are coding not the current date."),
--   international_support_notes STRING OPTIONS(description="Additional details about E4 policy actions"),
--   public_information_campaigns STRING OPTIONS(description="H1 - Ordinal scale record presence of public info campaigns;  0 -No COVID-19 public information campaign 1 - public officials urging caution about COVID-19 2 - coordinated public information campaign (e.g. across traditional and social media) No data - blank"),
--   public_information_campaigns_flag STRING OPTIONS(description="Sector scope of H1 actions;  0 - formal sector workers only 1 - transfers to informal sector workers too No data - blank"),
--   public_information_campaigns_notes STRING OPTIONS(description="Additional details about H1 policy actions"),
--   testing_policy STRING OPTIONS(description="H2 - Ordinal scale record of who can get tested;  0 – No testing policy 1 – Only those both (a) have symptoms AND (b) meet specific criteria (eg key workers admitted to hospital came into contact with a known case returned from overseas) 2 – testing of anyone showing COVID-19 symptoms 3 – open public testing (eg “drive through” testing available to asymptomatic people) No data Nb we are looking for policies about testing for having an infection (PCR tests) - not for policies about testing for immunity (antibody tests)."),
--   testing_policy_notes STRING OPTIONS(description="Additional details about H2 policy actions"),
--   contact_tracing STRING OPTIONS(description="H3 - Ordinal scale record if governments doing contact tracing; 0 - No contact tracing 1 - Limited contact tracing - not done for all cases 2 - Comprehensive contact tracing - done for all cases No data"),
--   contact_tracing_notes STRING OPTIONS(description="Additional details about H3 policy actions"),
--   emergency_healthcare_investment FLOAT64 OPTIONS(description="H4 - Short-term spending on e.g hospitals masks etc Record monetary value in USD of new short-term spending on health. If none enter 0. No data - blank Please use the exchange rate of the date you are coding not the current date."),
--   emergency_healthcare_investment_notes STRING OPTIONS(description="Additional details about H4 policy actions"),
--   vaccine_investment FLOAT64 OPTIONS(description="H5 - Announced public spending on vaccine development in USD; Record monetary value in USD of new short-term spending on health. If none enter 0. No data - blank Please use the exchange rate of the date you are coding not the current date."),
--   vaccine_investment_notes STRING OPTIONS(description="Additional details about H5 policy actions"),
--   misc_wildcard STRING OPTIONS(description="M1 - Record policy announcements that do not fit anywhere else"),
--   misc_wildcard_notes STRING OPTIONS(description="Additional details about M1 policy actions"),
--   confirmed_cases INT64 OPTIONS(description="Number of confirmed COVID-19 cases"),
--   deaths INT64 OPTIONS(description="Number of confirmed COVID-19 deaths"),
--   stringency_index FLOAT64 OPTIONS(description="Used after April 28 2020. Nine-point aggregation of the eight containment and closure indicators as well as H1 (public information campaigns). It reports a number between 0 to 100 that reflects the overall stringency of the governments response. This is a measure of how many of the these nine indicators (mostly around social isolation) a government has acted upon and to what degree.")
-- )
-- PARTITION BY date
-- OPTIONS (
--   partition_expiration_days = 2175
-- );

-- 2) Partitioned table + load (excluding GBR/BRA/CAN/USA)
CREATE OR REPLACE TABLE `qwiklabs-gcp-03-f29811fba497.covid.oxford_policy_tracker`
PARTITION BY date
OPTIONS (
  partition_expiration_days = 2175
) AS
SELECT *
FROM `bigquery-public-data.covid19_govt_response.oxford_policy_tracker`
WHERE alpha_3_code NOT IN ('GBR', 'BRA', 'CAN', 'USA')
;

-- TASK 2
-- Populate the mobility record data
-- In this task, you need to add the mobility record data, which requires to extract average values for the six component fields that comprise the mobility record data from the mobility_report table from the Google COVID 19 Mobility public dataset .

-- Your coworker has also given you a SQL snippet that is currently being used to analyze trends in the Google Mobility data daily mobility patterns. You might need to use this as part of the query that will add the daily country data for the mobility record in table provided in the task description.

-- SELECT country_region, date,
-- AVG(retail_and_recreation_percent_change_from_baseline) as avg_retail,
-- AVG(grocery_and_pharmacy_percent_change_from_baseline) as avg_grocery,
-- AVG(parks_percent_change_from_baseline) as avg_parks,
-- AVG(transit_stations_percent_change_from_baseline) as avg_transit,
-- AVG( workplaces_percent_change_from_baseline ) as avg_workplace,
-- AVG( residential_percent_change_from_baseline) as avg_residential
-- FROM `bigquery-public-data.covid19_google_mobility.mobility_report`
-- GROUP BY country_region, date
-- Verify the pre-created BigQuery dataset 'covid_data' within this dataset, populate the mobility record in 'consolidate_covid_tracker_data' table with data from the Google COVID 19 Mobility public dataset .
-- Note: In case you're unable to view pre-created resources in bigquery as per the task description,"your Google Cloud resources are still being provisioned, please refresh the page and try again in a few minutes." If you do, just wait a short time and reload your page.

UPDATE `qwiklabs-gcp-03-f29811fba497.covid_data.consolidate_covid_tracker_data` t1
SET
  t1.mobility.avg_retail        = t2.avg_retail,
  t1.mobility.avg_grocery       = t2.avg_grocery,
  t1.mobility.avg_parks         = t2.avg_parks,
  t1.mobility.avg_transit       = t2.avg_transit,
  t1.mobility.avg_workplace     = t2.avg_workplace,
  t1.mobility.avg_residential   = t2.avg_residential
FROM (
  SELECT 
    country_region, 
    date,
    AVG(retail_and_recreation_percent_change_from_baseline) as avg_retail,
    AVG(grocery_and_pharmacy_percent_change_from_baseline) as avg_grocery,
    AVG(parks_percent_change_from_baseline) as avg_parks,
    AVG(transit_stations_percent_change_from_baseline) as avg_transit,
    AVG( workplaces_percent_change_from_baseline ) as avg_workplace,
    AVG( residential_percent_change_from_baseline) as avg_residential
  FROM `bigquery-public-data.covid19_google_mobility.mobility_report`
  GROUP BY country_region, date
) AS t2
WHERE 
  CONCAT(t1.country_name, t1.date) = CONCAT(t2.country_region, t2.date)
;

-- TASK 3

-- Query missing data in population & country_area columns
-- In this task, you need to find out the countries which do not have population data and countries that do not have country area information.

-- Within the BigQuery dataset named 'covid_data' contains one table named oxford_policy_tracker_worldwide, run a query to find the missing countries in the population and country_area data from 'oxford_policy_tracker_worldwide' table . The query should list countries that do not have any population data and countries that do not have country area information, ordered by country name. If a country has neither population or country area it must appear twice.

-- Note: In case you're unable to view pre-created resources in bigquery as per the task description,"your Google Cloud resources are still being provisioned, please refresh the page and try again in a few minutes." If you do, just wait a short time and reload your page.

-- SELECT *
-- FROM `qwiklabs-gcp-03-f29811fba497.covid_data.oxford_policy_tracker_worldwide`
-- ;

WITH cte AS (
  SELECT
    DISTINCT
    country_name
  FROM `qwiklabs-gcp-03-f29811fba497.covid_data.oxford_policy_tracker_worldwide`
  WHERE country_area IS NULL
  UNION ALL
  SELECT 
    DISTINCT
    country_name
  FROM `qwiklabs-gcp-03-f29811fba497.covid_data.oxford_policy_tracker_worldwide`
  WHERE population IS NULL
)
SELECT *
FROM cte
ORDER BY 1
;

-- TASK 4

-- Create a new table for country population data
-- In this step, you need to create a copy of covid_19_geographic_distribution_worldwide table from European Center for Disease Control COVID 19 public dataset into your dataset provided in the task description.

-- Create a new table 'pop_data_2019' within the dataset named as 'covid_data'. The table should initially use the schema defined for the 'covid_19_geographic_distribution_worldwide' table data from the European Center for Disease Control COVID 19 public dataset.
-- Add the country population data to the 'pop_data_2019' table with covid_19_geographic_distribution_worldwide table data from the European Center for Disease Control COVID 19 public dataset.

-- Note: In case you're unable to view pre-created resources in bigquery as per the task description,"your Google Cloud resources are still being provisioned, please refresh the page and try again in a few minutes." If you do, just wait a short time and reload your page.

CREATE OR REPLACE TABLE `qwiklabs-gcp-03-f29811fba497.covid_data.pop_data_2019`
-- PARTITION BY date
-- OPTIONS (
--   partition_expiration_days = 2175
-- ) 
AS
SELECT *
FROM `bigquery-public-data.covid19_ecdc.covid_19_geographic_distribution_worldwide`
-- WHERE alpha_3_code NOT IN ('GBR', 'BRA', 'CAN', 'USA')
;
