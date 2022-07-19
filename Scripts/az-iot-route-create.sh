while [ "$#" -gt 0 ]; do
    case "$1" in
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

az extension add --name azure-iot -y

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
