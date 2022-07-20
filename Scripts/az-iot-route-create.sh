while [ "$#" -gt 0 ]; do
    case "$1" in
        --subscription_id)                subscription_id="$2" ;;
        --resource_group)                 resource_group="$2" ;;
        --hub_name)                       hub_name="$2" ;;
        --endpoint_name)                  endpoint_name="$2" ;;
        --endpoint_resource_group)        endpoint_resource_group="$2" ;;
        --endpoint_subscription_id)       endpoint_subscription_id="$2" ;;
        --endpoint_type)                  endpoint_type="$2" ;;
        --auth_type)                      auth_type="$2" ;;
        --identity)                       identity="$2" ;;
        --route_name)                     route_name="$2" ;;
        --route_source)                   route_source="$2" ;;
        --route_condition)                route_condition="$2" ;;
    esac
    shift
done

az account set -s $subscription_id
az extension add --name azure-iot -y

endpoint=$(az iot hub routing-endpoint show \
    --resource-group $resource_group \
    --hub-name $hub_name \
    --endpoint-name $endpoint_name)

if [ -z $endpoint];
then
    az iot hub routing-endpoint create \
        --resource-group $resource_group \
        --hub-name $hub_name \
        --endpoint-name $endpoint_name \
        --endpoint-resource-group $endpoint_resource_group \
        --endpoint-subscription-id $endpoint_subscription_id \
        --endpoint-type $endpoint_type \
        --auth-type $auth_type \
        --identity $identity \
        -o none

    if [[ $? -gt 0 ]]
    then
        exit 1
    fi
else
  echo 'endpoint exists, skipping creation'
fi

route=$(az iot hub route show \
    --resource-group $resource_group \
    --hub-name $hub_name \
    --name $route_name)

if [ -z $route];
then
    az iot hub route create \
        --resource-group $resource_group \
        --hub-name $hub_name \
        --endpoint-name $endpoint_name \
        --name $route_name \
        --source $route_source \
        --condition $route_condition \
        -o none
else
  echo 'route exists, skipping creation'
fi