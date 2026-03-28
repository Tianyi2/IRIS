resource "aws_glue_workflow" "pipeline" {
  name = "etl_pipeline"
}

# In UTC timezone
resource "aws_glue_trigger" "pipeline_scheduler" {
  name          = "pipeline_scheduler"
  schedule      = "cron(0 22 * * ? *)"
  type          = "SCHEDULED"
  workflow_name = aws_glue_workflow.pipeline.name

  actions {
    job_name = aws_glue_job.jobs["raw_to_staging.py"].name
  }
}

resource "aws_glue_trigger" "pipeline_wait" {
  name          = "pipeline_wait"
  type          = "CONDITIONAL"
  workflow_name = aws_glue_workflow.pipeline.name

  predicate {
    conditions {
      job_name = aws_glue_job.jobs["raw_to_staging.py"].name
      state    = "SUCCEEDED"
    }
  }

  actions {
    job_name = aws_glue_job.jobs["c_order_agg.py"].name
  }
}

resource "aws_glue_workflow" "optimize_iceberg" {
  name = "optimize_iceberg"
}

resource "aws_glue_trigger" "optimize_iceberg_sheduler" {
  name          = "optimize_iceberg_tables_sheduler"
  schedule      = "cron(0 3 ? * 1 *)"
  type          = "SCHEDULED"
  workflow_name = aws_glue_workflow.optimize_iceberg.name

  actions {
    job_name = aws_glue_job.jobs["optimize_iceberg.py"].name
  }
}