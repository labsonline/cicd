# Workflow Cleanup

```bash
OWNER=<your user/org name>
REPO=<repo name>

## List workflows
gh api -X GET /repos/$OWNER/$REPO/actions/workflows | jq '.workflows[] | .name,.id' | tee /tmp/${OWNER}-${REPO}-workflow-list.txt

## copy the ID of the workflow you want to clear and set it
WORKFLOW_ID=<workflow id>

## List runs
gh api -X GET /repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_ID/runs --paginate | jq '.workflow_runs[] | .id'

## Delete runs
gh api -X GET /repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_ID/runs --paginate | jq '.workflow_runs[] | .id' | xargs -I{} gh api -X DELETE /repos/$OWNER/$REPO/actions/runs/{} --silent
```

**_from: https://stackoverflow.com/a/65539398_**
