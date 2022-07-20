while [ "$#" -gt 0 ]; do
    case "$1" in
        --subscription_id)                subscription_id="$2" ;;
        --resource_group)                 resource_group="$2" ;;
        --hub_name)                       hub_name="$2" ;;
        --auth_method)                    auth_method="$2" ;;
        --device_id)                      device_id="$2" ;;
    esac
    shift
done

az account set -s $subscription_id -o none
az extension add --name azure-iot -y -o none

device=$(az iot hub device-identity show \
    --resource-group $resource_group \
    --hub-name $hub_name \
    --device-id $device_id)

if [ -z $device];
then
    az iot hub device-identity create \
        --resource-group $resource_group \
        --hub-name $hub_name \
        --device-id $device_id \
        --auth-method $auth_method \
        -o none
else
  echo 'device exists, skipping creation'
fi
