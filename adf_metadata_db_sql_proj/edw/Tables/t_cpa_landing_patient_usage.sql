CREATE TABLE [edw].[t_cpa_landing_patient_usage]
(
  mth_id int,
mkt_code nvarchar(50) NULL,
mole_name nvarchar(50) NULL,
brd_name nvarchar(50) NULL,
standard_sku nvarchar(50) NULL,
tabs_per_pack float,
indc_split_rate decimal(38,5) NULL,
volumeperyear float,
tabsperyear float
)
