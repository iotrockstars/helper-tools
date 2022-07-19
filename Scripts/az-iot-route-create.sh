hub_name=$1
endpoint_name=$2
endpoint_resource_group=$3
endpoint_subscription_id=$4
endpoint_type=$5
auth_type=$6
identity=$7
route_name=$8
route_source=$9
route_condition=${10}

az iot hub routing-endpoint create \
    --hub-name $hub_name \
    --endpoint-name $endpoint_name \
    --endpoint-resource-group $endpoint_resource_group \
    --endpoint-subscription-id $endpoint_subscription_id \
    --endpoint-type $endpoint_type \
    --auth-type $auth_type \
    --identity $identity

az iot hub route create \
    --endpoint-name $endpoint_name \
    --hub-name $hub_name \
    --name $route_name \
    --source $route_source \
    --condition $route_condition
    --enabled true
