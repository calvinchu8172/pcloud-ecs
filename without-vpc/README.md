# myZyXEL ECS

## Plan

```
AWS_PROFILE={aws\_profile\_for\_env} terraform plan -var 'region=us-east-1' -var 'env=alpha' -var 'creator=ChouAndy' -state=states/alpha/us-east-1/terraform.tfstate
```

## Apply

### Apply All Resources

```
AWS_PROFILE={aws\_profile\_for\_env} terraform apply -var 'region=us-east-1' -var 'env=alpha' -var 'creator=ChouAndy' -state=states/alpha/us-east-1/terraform.tfstate -backup=states/alpha/us-east-1/terraform.tfstate.backup
```

### Apply Specific Resource

```
AWS_PROFILE={aws\_profile\_for\_env} terraform apply -var 'region=us-east-1' -var 'env=alpha' -var 'creator=ChouAndy' -state=states/alpha/us-east-1/terraform.tfstate -backup=states/alpha/us-east-1/terraform.tfstate.backup -target=[module path][resource spec]
```

## Refresh

1. 執行以下指令

```
AWS_PROFILE={aws\_profile\_for\_env} terraform refresh -var 'region=us-east-1' -var 'env=alpha' -var 'creator=ChouAndy' -state=states/alpha/us-east-1/terraform.tfstate
```

2. 更新 task definition revision
