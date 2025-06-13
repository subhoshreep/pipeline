param Name string='{Name}'
param Path string='{Path}'
param OperationName string='{OperationName}'
param alloperationlevel string='{alloperationlevel}'
param policyapilevelput string='{policyapilevelput}'
param displayname string='{displayname}'
param testorprod string = '{testorprod}'

//Script created by Anagh to deploy APIM Interface in Azure

//Create API Instance
resource CreateAPi 'Microsoft.ApiManagement/service/apis@2021-08-01'={
  name:Name
 
properties: {
    apiType: 'http'
    description: 'RPA To APIM'
    displayName: displayname
    format: 'openapi'
    isCurrent: true
    subscriptionRequired:false
   
    path: Path
    protocols: [
      'https'
    ]
   
     termsOfServiceUrl: 'Test'
    type: 'http'
  
  }
  
}

// post Operation
resource postoperation 'Microsoft.ApiManagement/service/apis/operations@2021-12-01-preview' = {
  name: OperationName
  properties: {
 
    displayName: 'postdata'
    method: 'Post'
    urlTemplate: '/zendeskrefund'
   
    policies:'OperationLevel'
  }
  dependsOn:[CreateAPi]

}

 //Create Policy at all operations level
 resource policyoperationlevel 'Microsoft.ApiManagement/service/apis/policies@2021-12-01-preview' = {
  
  name: alloperationlevel
  properties: {
    value: loadTextContent('./Policies/policyapilevel.xml')
    format:'rawxml'
  }
  dependsOn: [postoperation]
}

 //Create Policy at all operations level
 resource policyatapilevelput 'Microsoft.ApiManagement/service/apis/operations/policies@2021-12-01-preview' =if (testorprod == 'test') {
  name: policyapilevelput
  properties: {
    value: loadTextContent('./Policies/policyoplevelpost.xml')
   format: 'rawxml'
  }
  dependsOn: [policyoperationlevel]
}



 //Create Policy at all operations level in prod
 resource policyatapilevelputprod 'Microsoft.ApiManagement/service/apis/operations/policies@2021-12-01-preview' =if (testorprod == 'prod') {
  name: policyapilevelput
  properties: {
    value: loadTextContent('./Policies/policyoplevelpostprd.xml')
   format: 'rawxml'
  }
  dependsOn: [policyoperationlevel]
}
