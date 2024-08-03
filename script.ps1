# Define parameters
$resourceGroupName = "myResourceGroup"     # Change to your resource group name
$location = "CanadaCentral"                       # Change to your desired Azure region
$storageAccountName = "my202408032026storageacc" # Change to a unique storage account name
$sku = "Standard_LRS"                      # Change to your desired SKU (e.g., Standard_LRS, Premium_LRS)

# Authenticate to Azure
Connect-AzAccount

# Create a resource group if it doesn't already exist
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue

if (-not $resourceGroup) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
    Write-Host "Created resource group: $resourceGroupName"
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}

# Create the storage account
try {
    New-AzStorageAccount `
      -ResourceGroupName $resourceGroupName `
      -Name $storageAccountName `
      -SkuName $sku `
      -Location $location `
      -Kind "StorageV2"    # You can also use "BlobStorage", "FileStorage", etc.

    Write-Host "Storage account '$storageAccountName' created successfully."
} catch {
    Write-Host "Error creating storage account: $_"
}
