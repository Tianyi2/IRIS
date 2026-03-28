# state_management.tf (Workflow State and Queueing)

# -----------------------------------------------------------------------------
# --- SQS FIFO QUEUE ---
# This FIFO (First-In, First-Out) queue holds the lists of match IDs that need
# to be processed by the transformation Lambda, ensuring orderly processing.
# -----------------------------------------------------------------------------
resource "aws_sqs_queue" "player_processing_queue" {
  name                        = "gg-analyzer-player-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = false
  delay_seconds               = 120
  visibility_timeout_seconds  = 310
}

# -----------------------------------------------------------------------------
# --- DYNAMODB TABLE ---
# This table is used to prevent duplicate work. The transformation Lambda checks
# this table to see if a specific match/champion combination has already been
# processed before fetching data from the Riot API.
# -----------------------------------------------------------------------------
resource "aws_dynamodb_table" "processed_matches_table" {
  name         = "gganalyzer-processed-matches-v2"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "match_id"
  range_key = "champion_name"

  attribute {
    name = "match_id"
    type = "S"
  }

  attribute {
    name = "champion_name"
    type = "S"
  }
}