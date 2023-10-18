/*

It makes sense to deploy some resources only within the context of their parent. 
These are called child resources. 
There are many child resource types in Azure. Here are a few examples:

Name	          Resource          type
Virtual         network           subnets	Microsoft.Network/virtualNetworks/subnets
App Service     configuration	    Microsoft.Web/sites/config


*/


//Nested Resources

param location string='westus3'
param vmname string ='test'

resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmname
  location: location
  properties: {
    // ...
  }

  //Child Resource
  //we dont have to mention resource type in detail it takes it from parent 
  resource installCustomScriptExtension 'extensions' = {
    name: 'InstallCustomScript'
    location: location
    properties: {
      // ...
    }
  }
}



//Using Parent property

resource vmv2 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmname
  location: location
  properties: {
    // ...
  }
}

//We have to mention resource type and id using parent property without nesting
resource installCustomScriptExtension 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  parent: vm
  name: 'InstallCustomScriptV2'
  location: location
  properties: {
    // ...
  }
}

/*
There are some circumstances where you can't use nested resources or the parent keyword.
 Examples include when you declare child resources within a for loop, 
 or when you need to use complex expressions to dynamically 
 select a parent resource for a child. 
 In these situations, you can deploy a child resource by 
 manually constructing the child resource name so that it
  includes its parent resource name, as shown here:

*/


//Use this only when other approach doesnt work

resource vmv3 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmname
  location: location
  properties: {
    // ...
  }
}

resource installCustomScriptExtensionv3 'Microsoft.Compute/virtualMachines/extensions@2020-06-01' = {
  name: '${vmv3.name}/InstallCustomScript'
  dependsOn: [
    vmv3
  ]
  location: location
  properties: {
    // ...
  }
}
