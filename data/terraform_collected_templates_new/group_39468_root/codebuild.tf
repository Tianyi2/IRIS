#-----------------------------------------------------------------------------------------------------------------------
# ドキュメント作成用CodeBuild
#-----------------------------------------------------------------------------------------------------------------------
resource "aws_codebuild_project" "codecommit_pages_proj" {
  name           = local.codebuild_proj_name
  source_version = "refs/heads/${local.codecommit_branch_name}"

  service_role = aws_iam_role.codebuild_iam_role.arn

  source {
    type            = "CODECOMMIT"
    buildspec       = file("source/buildspec.yml")
    location        = aws_codecommit_repository.codecommit_pages.clone_url_http
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = false
    }
  }

  environment {
    # Docker in Dockerでdocker実行する場合はprivileged_modeをtrueにする
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "jekyll/jekyll:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false

    #-------------------------------------------------------------------------------------------------------------------
    # CodeBuild用環境変数
    #-------------------------------------------------------------------------------------------------------------------
    # リージョン
    environment_variable {
      name  = "REGION"
      value = data.aws_region.current.name
    }
    # CodeCommitリポジトリ名とドキュメント生成元ディレクトリ
    environment_variable {
      name  = "REPOSITORY"
      value = local.codecommit_repository
    }
    environment_variable {
      name  = "GLIBC_VERSION"
      value = local.aws_cli_install_glibc_version
    }
    # ルートディレクトリ以外に生成元ドキュメントを格納する場合に指定する環境変数
    environment_variable {
      name  = "SRC_DIR"
      value = local.codecommit_pages_src_dir
    }
    # ドキュメント作成シェルに指定する環境変数
    environment_variable {
      name  = "PROTOCOL"
      value = local.codecommit_pages_protocol
    }
    environment_variable {
      name  = "S3_BUCKET_NAME"
      value = aws_s3_bucket.bucket.id
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.codecommit_pages.name
      stream_name = local.codebuild_log_stream_name
    }
  }
}

#-----------------------------------------------------------------------------------------------------------------------
# buildspec.ymlファイルの配置
#-----------------------------------------------------------------------------------------------------------------------
# S3バケットにbuildspec.ymlファイルを配置する場合に使用
# S3バケットにbuildspec.ymlファイルを配置する
# "aws_s3_object"でファイルを配置した際に"Content-Type"が"binary/octet-stream"になることの対処。
# module "send_buildspec" {
#   source   = "hashicorp/dir/template"
#   base_dir = "./source"
# }

# # buildspec.ymlをS3に配置する。
# resource "aws_s3_object" "send_file" {
#   for_each = module.send_buildspec.files

#   bucket       = "${aws_s3_bucket.bucket.id}"
#   key          = each.key
#   source       = each.value.source_path
#   content      = each.value.content
#   content_type = each.value.content_type
#   etag         = each.value.digests.md5
# }
