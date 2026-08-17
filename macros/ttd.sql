{% macro ttd(source_name, table_name,cm360_source_name,cm360_table_name) %}
WITH parsed_data AS (
    SELECT
        FORMAT_DATE('%Y-%m-%d', PARSE_DATE('%d/%m/%Y', JSON_VALUE(JSON_EXTRACT(data, "$.Date")))) AS date,
        JSON_VALUE(JSON_EXTRACT(data, "$.Partner ID")) AS partner_id,
        JSON_VALUE(JSON_EXTRACT(data, "$.Advertiser ID")) AS advertiser_id,
        JSON_VALUE(JSON_EXTRACT(data, "$.Campaign ID")) AS campaign_id,
        JSON_VALUE(JSON_EXTRACT(data, "$.Ad Group ID")) AS ad_group_id,
      
        JSON_VALUE(JSON_EXTRACT(data, "$.Ad Format")) AS ad_format,
        _sdc_extracted_at,
        JSON_VALUE(JSON_EXTRACT(data, "$.Creative ID")) AS creative_id,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Frequency")) AS FLOAT64) AS frequency,
        JSON_VALUE(JSON_EXTRACT(data, "$.Advertiser")) AS advertiser,
        JSON_VALUE(JSON_EXTRACT(data, "$.Campaign")) AS campaign_name,
        JSON_VALUE(JSON_EXTRACT(data, "$.Ad Group")) AS ad_group,
        JSON_VALUE(JSON_EXTRACT(data, "$.Advertiser Currency Code")) AS advertiser_currency_code,
        JSON_VALUE(JSON_EXTRACT(data, "$.Partner Currency Code")) AS partner_currency_code,
        JSON_VALUE(JSON_EXTRACT(data, "$.Creative")) AS creative,
        JSON_VALUE(JSON_EXTRACT(data, "$.Deal ID")) AS deal_id,
        JSON_VALUE(JSON_EXTRACT(data, "$.Ad Server Name")) AS ad_server_name,
        JSON_VALUE(JSON_EXTRACT(data, "$.Ad Server Creative Placement ID")) AS ad_server_creative_placement_id,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Bids")) AS INT64) AS bids,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Total Bid Amount (Adv Currency)']")), ',', '.') AS FLOAT64) AS total_bid_amount_adv_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Total Bid Amount (Partner Currency)']")), ',', '.') AS FLOAT64) AS total_bid_amount_partner_currency,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Impressions")) AS INT64) AS impressions,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Clicks")) AS INT64) AS clicks,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['TTD Cost (Adv Currency)']")), ',', '.') AS FLOAT64) AS ttd_cost_adv_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['TTD Cost (Partner Currency)']")), ',', '.') AS FLOAT64) AS ttd_cost_partner_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Partner Cost (Adv Currency)']")), ',', '.') AS FLOAT64) AS partner_cost_adv_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Partner Cost (Partner Currency)']")), ',', '.') AS FLOAT64) AS partner_cost_partner_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Advertiser Cost (Adv Currency)']")), ',', '.') AS FLOAT64) AS advertiser_cost_adv_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Advertiser Cost (Partner Currency)']")), ',', '.') AS FLOAT64) AS advertiser_cost_partner_currency,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Player 25% Complete']")), ',', '.') AS FLOAT64) AS player_25_complete,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Player 50% Complete']")), ',', '.') AS FLOAT64) AS player_50_complete,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Player 75% Complete']")), ',', '.') AS FLOAT64) AS player_75_complete,
        CAST(REPLACE(JSON_VALUE(JSON_EXTRACT(data, "$['Player 100% Complete']")), ',', '.') AS FLOAT64) AS player_100_complete,

        -- Example:
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Player Views")) AS INT64) AS video_views,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$.Player Starts")) AS INT64) AS player_starts,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Click Conversion']")) AS INT64) AS click_conversion_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Click Conversion Revenue']")) AS FLOAT64) AS click_Conversion_revenue_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Conversion Touch']")) AS INT64) AS conversion_touch_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['01 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_01,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Click Conversion']")) AS INT64) AS Click_Conversion_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Click Conversion Revenue']")) AS FLOAT64) AS Click_Conversion_Revenue_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Conversion Touch']")) AS INT64) AS Conversion_Touch_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['02 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_02,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Click Conversion']")) AS INT64) AS Click_Conversion_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Click Conversion Revenue']")) AS FLOAT64) AS Click_Conversion_Revenue_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Conversion Touch']")) AS INT64) AS Conversion_Touch_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['03 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_03,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Click Conversion']")) AS INT64) AS Click_Conversion_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Click Conversion Revenue']")) AS FLOAT64) AS Click_Conversion_Revenue_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Conversion Touch']")) AS INT64) AS Conversion_Touch_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['04 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_04,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Click Conversion']")) AS INT64) AS Click_Conversion_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Click Conversion Revenue']")) AS FLOAT64) AS Click_Conversion_Revenue_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Conversion Touch']")) AS INT64) AS Conversion_Touch_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['05 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_05,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Click Conversion']")) AS INT64) AS Click_Conversion_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Click Conversion Revenue']")) AS FLOAT64) AS Click_Conversion_Revenue_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Conversion Touch']")) AS INT64) AS Conversion_Touch_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Conversion Touch Revenue']")) AS FLOAT64) AS Conversion_Touch_Revenue_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - View Through Conversion']")) AS INT64) AS View_Through_Conversion_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - View Through Conversion Revenue']")) AS FLOAT64) AS View_Through_Conversion_Revenue_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Time Weighted Decay Conversion']")) AS INT64) AS Time_Weighted_Decay_Conversion_06,
        CAST(JSON_VALUE(JSON_EXTRACT(data, "$['06 - Time Weighted Decay Conversion Revenue']")) AS FLOAT64) AS Time_Weighted_Decay_Conversion_Revenue_06

    FROM
       {{ source(source_name, table_name) }}
),
# Rank the data by the extracted_at timestamp
ranked_data AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                Date, partner_id, advertiser_id, campaign_id, ad_group_id, ad_format, creative_id, 
                  deal_id, ad_server_creative_placement_id
            order by
                _sdc_extracted_at desc
        ) AS row_num
    FROM
        parsed_data
),
non_audience_deduplicate_data AS (
    SELECT * FROM ranked_data WHERE row_num = 1
),
deduplicate_data AS (
    SELECT * except(ad_group),ARRAY_REVERSE(SPLIT(ad_group, '_'))[SAFE_OFFSET(0)] AS audience_name
    FROM non_audience_deduplicate_data
),
cm360_campaign_creative AS (
   SELECT 
   'NZD' AS ad_server_creative_placement_id,
   'cm360' AS ad_server_name,
   SAFE_CAST(date AS STRING) AS date,
   placement AS campaign_name,
   placement_id AS campaign_id,
   creative_name,
   creative_id,
   'CM360' AS advertiser,
   ' ' AS advertiser_id,
   ' ' AS audience_name,
    SUM(video_25_completion) AS video_25_completion,
    SUM(video_50_completion) AS video_50_completion,
    SUM(video_75_completion) AS video_75_completion,
    SUM(video_completion) AS video_completion,
    SUM(clicks) AS clicks,
    SUM(video_views) AS video_views,
    SUM(impressions) AS impressions,
    SUM(dv360_cost) AS media_cost,
    CASE WHEN ARRAY_LENGTH(SPLIT(creative_name, '_')) >= 7 THEN  SPLIT(creative_name, '_')[SAFE_OFFSET(5)] 
         ELSE 'Other' END AS ad_format

   from {{ source(cm360_source_name, cm360_table_name) }}
   WHERE placement IN (
    SELECT DISTINCT campaign_name FROM parsed_data
   )
   GROUP BY 
   date,placement,placement_id,creative_name,creative_id,ad_format,audience_name
),
pre_process_cm360_match_data AS (
  SELECT 
        ad_server_creative_placement_id,
        ad_server_name,
        date, -- Keep this as-is for joining purposes
        campaign_name,
        campaign_id,
        creative as creative_name,
        creative_id,
        advertiser,
        advertiser_id,
        audience_name,
        SUM(player_25_complete) AS video_25_completion,
        SUM(player_50_complete) AS video_50_completion,
        SUM(player_75_complete) AS video_75_completion,
        SUM(player_100_complete) AS video_completion,
        SUM(clicks) AS clicks,
        SUM(video_views) AS video_views,
        SUM(impressions) AS impressions,
        SUM(partner_cost_partner_currency) AS media_cost,
        ad_format
    FROM deduplicate_data
    
    WHERE NOT campaign_name IN (
        SELECT DISTINCT placement FROM {{ source(cm360_source_name, cm360_table_name) }}
    )
    GROUP BY 
            ad_server_creative_placement_id, ad_server_name, date, campaign_name, campaign_id, creative, creative_id, advertiser, advertiser_id,ad_format,audience_name
    ),
joining AS (
    (SELECT * FROM pre_process_cm360_match_data)
    UNION ALL
    (SELECT * FROM cm360_campaign_creative)
),

final AS (
select * ,
CASE 
    WHEN LOWER(campaign_name) LIKE '%acast%' OR LOWER(creative_name) LIKE '%acast%' THEN 'Acast'
    WHEN LOWER(campaign_name) LIKE '%3now%' OR LOWER(creative_name) LIKE '%3now%' OR LOWER(campaign_name) LIKE '%three%' OR LOWER(creative_name) LIKE '%three%' OR (
        LOWER(campaign_name) LIKE '%3 now%' OR LOWER(creative_name) LIKE '%3 now%')
        THEN 'Threenow'
    WHEN LOWER(campaign_name) LIKE '%nzme%' OR LOWER(creative_name) LIKE '%nzme%' THEN 'Nzme'
    WHEN LOWER(campaign_name) LIKE '%tvnz%' OR LOWER(creative_name) LIKE '%tvnz%' THEN 'Tvnz'
    WHEN LOWER(campaign_name) LIKE '%youtube%' OR LOWER(creative_name) LIKE '%yt%' or lower(creative_name) LIKE '%youtube%' or   LOWER(campaign_name) LIKE '%yt%' THEN 'Youtube'
    WHEN LOWER(campaign_name) LIKE '%stuff%' OR LOWER(creative_name) LIKE '%stuff%' THEN 'Stuff'
    ELSE 'Ttd'
END AS publisher,
    CASE WHEN ARRAY_LENGTH(SPLIT(creative_name, '_')) >= 8 THEN SPLIT(creative_name, '_')[SAFE_OFFSET(7)] 
         ELSE 'Other' END AS creative_descr,
    CASE WHEN ARRAY_LENGTH(SPLIT(creative_name, '_')) >= 7 THEN  SPLIT(creative_name, '_')[SAFE_OFFSET(5)] 
         ELSE 'Other' END AS ad_format_detail,
    CASE WHEN ARRAY_LENGTH(SPLIT(campaign_name,'_')) <=1 THEN 'Other'
        ELSE SPLIT(campaign_name,'_')[SAFE_OFFSET(1)] END AS campaign_descr,

from joining
)
SELECT 
        ad_server_creative_placement_id,
        ad_server_name,
        date, -- Keep this as-is for joining purposes
        campaign_name,
        campaign_id,
        creative_name,
        creative_id,
        advertiser,
        advertiser_id,
        publisher,
        audience_name,
        ad_format,
        ad_format_detail,
        creative_descr,
        campaign_descr,
        SUM(video_25_completion) AS video_25_completion,
        SUM(video_50_completion) AS video_50_completion,
        SUM(video_75_completion) AS video_75_completion,
        SUM(video_completion) AS video_completion,
        SUM(clicks) AS clicks,
        SUM(video_views) AS video_views,
        SUM(impressions) AS impressions,
        SUM(media_cost) AS media_cost -- Aggregate Partner Cost
    FROM final
    GROUP BY 
        ad_server_creative_placement_id, ad_server_name, date, campaign_name, campaign_id, creative_name, creative_id, advertiser, advertiser_id,publisher,
        audience_name,ad_format,ad_format_detail,creative_descr,campaign_descr
{% endmacro %}