
param subnetoutput array

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'production-nic'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'toy-subnet-ip-configuration'
        properties: {
          subnet: [for (subnetid,i) in range(0,length(subnetoutput)):{
            id: subnetid //Using Output array 
          }]
        }
      }
    ]
  }
}
