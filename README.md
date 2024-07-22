# MLOps

# terraform

作成するリソース

- AWS CodeCommit
- AWS CodePipeline
- AWS CodeBuild
- AWS CodeDeploy
- AWS S3
- Databricks Workspace
- Databricks クラスタ
- Databricks ジョブ(ワークフロー)
- Databricks unity catalog
- Databricks unity schema
- Databricks unity volume

## codecommit

```
pyenv local 3.12.0
python --version
pip install git-remote-codecommit
git remote set-url codecommit codecommit::ap-northeast-1://mlops-test-iitos
```
