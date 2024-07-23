# クラスター上でノートブックを実行するジョブ
resource "databricks_job" "this" {
  name = var.job_name

  # 新しくクラスターを作成する場合
  # new_cluster {
  #   num_workers   = 2
  #   spark_version = "7.3.x-scala2.12"
  #   node_type_id  = "Standard_DS3_v2"
  # }

  dynamic "task" {
    for_each = var.tasks
    content {
      task_key            = task.value.task_key
      existing_cluster_id = var.cluster_id
      notebook_task {
        notebook_path = task.value.notebook_path
      }
    }
  }

  # ジョブの実行結果を通知する場合
  # email_notifications {
  #   # AWS SNS topic arnでも指定可能
  #   on_success = ["sample111@gmail.com", sample"222@gmail.com"]
  #   on_start   = ["sample222@gmail.com"]
  #   on_failure = ["sample111@gmail.com", sample"222@gmail.com"]
  # }

  # job scheduleを指定する場合
  # schedule {
  #   quartz_cron_expression = "0 0 1 * * ?" # 毎日午前1時に実行
  #   timezone_id            = "UTC"         # タイムゾーンを設定
  # }

  timeout_seconds = 3600
}
