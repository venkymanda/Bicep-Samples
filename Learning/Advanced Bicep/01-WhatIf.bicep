/*
The az deployment group what-if command gives you a preview of what will happen if you carry out a deployment.

You can control the amount of text output of the what-if operation by using one of these result formats:

FullResourcePayloads. By including this parameter, you get a verbose output that consists of a list of resources that will change. The output also shows details about all the properties that will change in accordance with the template.
ResourceIdOnly. This mode returns a list of resources that will change, but not all the details.







Types of changes that what-if detects
When you use the what-if operation, it lists six types of changes:

Type	Explanation	Effect
Create	The resource doesn't currently exist but is defined in the template.	The resource will be created.
Delete	This change type applies only when you're using complete mode for deployment. The resource exists but isn't defined in the template.	If you deploy by using incremental mode, the resource isn't deleted. If you deploy by using complete mode, the resource is deleted. This change type is returned only for resources that support deletion through complete mode.
Ignore	The resource exists but isn't defined in the template.	When you use incremental mode, which is the default deployment mode, the resource isn't deployed or modified. If you deploy by using complete mode, the resource will be deleted.
NoChange	The resource exists and is defined in the template.	The resource will be redeployed, but the properties of the resource won't change. This change type is returned when the result format is set to FullResourcePayloads, which is the default result format.
Modify	The resource exists and is defined in the template.	The resource will be redeployed, and the properties of the resource will change. This change type is returned when the result format is set to FullResourcePayloads, which is the default result format.
Deploy	The resource exists and is defined in the template.	The resource will be redeployed. The properties of the resource might or might not change. The operation returns this change type when it doesn't have enough information to determine if any properties will change. You see this condition only when the result format is set to ResourceIdOnly.







Confirm your deployments
To preview changes before deploying a template, use the --confirm-with-what-if argument with the deployment command. If the changes are as you expected, acknowledge that you want the deployment to finish.

 Tip

It's a good idea to run your deployment commands with the --confirm-with-what-if argument, especially if you're deploying in complete mode. If you use the --confirm-with-what-if switch, you have a chance to stop the operation if you don't like the proposed changes.
*/




resource vnet 'Microsoft.Network/virtualNetworks@2018-10-01' = {
  name: 'vnet-001'
  location: resourceGroup().location
  tags: {
    'CostCenter': '12345'
  }
  properties: {
    
      addressSpace: {
        addressPrefixes: [
          '10.0.0.0/15'
        ]
      }
    
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: 'subnet002'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
