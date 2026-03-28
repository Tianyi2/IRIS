resource "aws_glue_catalog_database" "staging" {

  depends_on = [aws_lakeformation_data_lake_settings.admins]

  name = "staging"
}

resource "aws_glue_catalog_database" "reporting" {

  depends_on = [aws_lakeformation_data_lake_settings.admins]

  name = "reporting"
}

resource "aws_glue_catalog_database" "dbt" {

  depends_on = [aws_lakeformation_data_lake_settings.admins]

  name = "dbt"
}

resource "aws_glue_catalog_database" "dbt_test__audit" {

  depends_on = [aws_lakeformation_data_lake_settings.admins]

  name = "dbt_test__audit"
}