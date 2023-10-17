using './07-Secrets_with_parameters.bicep'

param sqlServerName = ''
param adminLogin = ''
param subscriptionId = ''
param kvResourceGroup = ''
param kvName = ''
param secureUserName = getSecret('exampleSubscription', 'exampleResourceGroup', 'exampleKeyVault', 'exampleSecretUserName', 'exampleSecretVersion')
param securePassword = az.getSecret('exampleSubscription', 'exampleResourceGroup', 'exampleKeyVault', 'exampleSecretPassword')

//Both are valid way to get azure key vault secrets
