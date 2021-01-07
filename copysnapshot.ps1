#Provide the subscription Id where the snapshot is created
$subscriptionId=""

#Provide the name of your resource group where the snapshot is created
$resourceGroupName="cloud-shell-storage-eastus"

#Provide the snapshot name
$snapshotName="transactofferbasesnapshot"

#Provide Shared Access Signature (SAS) expiry duration in seconds (such as 3600)
#Know more about SAS here: https://docs.microsoft.com/en-us/azure/storage/storage-dotnet-shared-access-signature-part-1
$sasExpiryDuration=3600

#Provide storage account name where you want to copy the underlying VHD file. 
$storageAccountName="transactoffer"

#Name of the storage container where the downloaded VHD will be stored.
$storageContainerName="diskimages"

#Provide the key of the storage account where you want to copy the VHD 
$storageAccountKey=""

#Give a name to the destination VHD file to which the VHD will be copied.
$destinationVHDFileName="transactoffertest.vhd"

az account set --subscription $subscriptionId

$sas=$(az snapshot grant-access --resource-group $resourceGroupName --name $snapshotName --duration-in-seconds $sasExpiryDuration --query [accessSas] -o tsv)

az storage blob copy start --destination-blob $destinationVHDFileName --destination-container $storageContainerName --account-name $storageAccountName --account-key $storageAccountKey --source-uri $sas