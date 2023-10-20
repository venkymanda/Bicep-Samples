param subnetNames array = [
  'api'
  'worker'
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: 'teddybear'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    //Use loops with resource properties
    subnets: [for (subnetName, i) in subnetNames: {
      name: subnetName
      properties: {
        addressPrefix: '10.0.${i}.0/24'
      }
    }]
  }
}

output virtualnetwork array= [for i in range(0,length(subnetNames)): {
  
  subnetresourceid:virtualNetwork.properties.subnets[i].id
}]



