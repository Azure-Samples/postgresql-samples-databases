

$PGParams = @{}
$PGParams.RGName = "timchappgtest6"
$PGParams.Location = "eastus"
$PGParams.PGServerName = "timchapflexpgtest6"
$PGParams.PGAdminUserName = "postgres"
$PGParams.PGAdminPassword = "Password12345!!"
$PGParams.PGSkuTier = "GeneralPurpose"
$PGParams.PGSku = "Standard_D2s_v3"

$PGFlexServer = create-AzPGFlexibleServer @PGParams