//Deploy across Multiple resource groups


targetScope ='resourceGroup'



module networkModule 'modules/network.bicep' = {
  scope: resourceGroup('ToyNetworking')
  name: 'networkModule'
}


module networkInterface 'modules/networkinterface.bicep' = {
  scope: resourceGroup('ToyNetworking')
  name: 'networkInterface'
  params:{
    subnetoutput:networkModule.outputs.virtualnetwork //Using output array from one module to Other
  }
}

