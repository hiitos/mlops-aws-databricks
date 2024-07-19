resource "databricks_workspace" "this" {
  name = var.workspace_name
}

resource "databricks_cluster" "this" {
  cluster_name            = var.cluster_name
  spark_version           = "7.3.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 10
  num_workers             = 2
}

resource "databricks_job" "this" {
  name = var.job_name

  new_cluster {
    num_workers   = 2
    spark_version = "7.3.x-scala2.12"
    node_type_id  = "Standard_DS3_v2"
  }

  notebook_task {
    notebook_path = var.notebook_path
  }

  timeout_seconds = 3600
}

resource "databricks_job" "name_of_my_job" {
  name                = "my_multi_task_job"
  max_concurrent_runs = 1

  # job schedule
  schedule {
    quartz_cron_expression = "0 0 0 ? 1/1 * *" # cron schedule of job
    timezone_id            = "UTC"
  }

  # notifications at job level
  email_notifications {
    on_success = ["111@abc.com", "222@abc.com"]
    on_start   = ["222@abc.com"]
    on_failure = ["my_distribution_list@abc.com"]
  }

  # reference to git repo. Add the git credential separately
  # through a databricks_git_credential resource
  git_source {
    url      = "https://github.com/udaysat-db/test-repo.git"
    provider = "gitHub"
    branch   = "main"
  }

  # Create blocks for Jobs Clusters here #

  # Create blocks for Tasks here #
}


output "workspace_name" {
  value = databricks_workspace.this.name
}

output "cluster_name" {
  value = databricks_cluster.this.cluster_name
}

output "job_name" {
  value = databricks_job.this.name
}
