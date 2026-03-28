// Bicep template for Log Analytics custom table: AzureNetworkAnalytics_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 178, Deployed columns: 176 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource azurenetworkanalyticsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AzureNetworkAnalytics_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AzureNetworkAnalytics_CL'
      description: 'Custom table AzureNetworkAnalytics_CL - imported from JSON schema'
      displayName: 'AzureNetworkAnalytics_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'Peer_s'
          type: 'string'
        }
        {
          name: 'RoutingWeight_d'
          type: 'real'
        }
        {
          name: 'VirtualNetworkGateway1_s'
          type: 'string'
        }
        {
          name: 'VirtualNetworkGateway2_s'
          type: 'string'
        }
        {
          name: 'AllowForwardedTraffic_b'
          type: 'string'
        }
        {
          name: 'AllowGatewayTransit_b'
          type: 'string'
        }
        {
          name: 'AllowVirtualNetworkAccess_b'
          type: 'string'
        }
        {
          name: 'UseRemoteGateways_b'
          type: 'string'
        }
        {
          name: 'LocalNetworkGateway_s'
          type: 'string'
        }
        {
          name: 'VirtualNetwork1_s'
          type: 'string'
        }
        {
          name: 'AppGatewayType_s'
          type: 'string'
        }
        {
          name: 'GatewaySubnet_s'
          type: 'string'
        }
        {
          name: 'PrivateFrontendIPs_s'
          type: 'string'
        }
        {
          name: 'PublicFrontendIPs_s'
          type: 'string'
        }
        {
          name: 'BackendSubnets_s'
          type: 'string'
        }
        {
          name: 'FrontendIPs_s'
          type: 'string'
        }
        {
          name: 'FrontendSubnet_s'
          type: 'string'
        }
        {
          name: 'FrontendSubnets_s'
          type: 'string'
        }
        {
          name: 'VirtualNetwork2_s'
          type: 'string'
        }
        {
          name: 'LoadBalancerType_s'
          type: 'string'
        }
        {
          name: 'IngressBytesTransferred_d'
          type: 'real'
        }
        {
          name: 'EgressBytesTransferred_d'
          type: 'real'
        }
        {
          name: 'LoadBalancerBackendPools_s'
          type: 'string'
        }
        {
          name: 'MACAddress_s'
          type: 'string'
        }
        {
          name: 'NSG_s'
          type: 'string'
        }
        {
          name: 'PrivateIPAddresses_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'PublicIPAddresses_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Subnetwork_s'
          type: 'string'
        }
        {
          name: 'VirtualMachine_s'
          type: 'string'
        }
        {
          name: 'IsVirtualAppliance_b'
          type: 'string'
        }
        {
          name: 'GatewayConnectionType_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'BGPEnabled_b'
          type: 'string'
        }
        {
          name: 'GatewayType_s'
          type: 'string'
        }
        {
          name: 'SKU_s'
          type: 'string'
        }
        {
          name: 'VIPAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'VirtualSubnetwork_s'
          type: 'string'
        }
        {
          name: 'VpnClientAddressPrefixes_s'
          type: 'string'
        }
        {
          name: 'ConnectionStatus_s'
          type: 'string'
        }
        {
          name: 'ConnectionType_s'
          type: 'string'
        }
        {
          name: 'SubnetPrefixes_s'
          type: 'string'
        }
        {
          name: 'EnableIPForwarding_b'
          type: 'string'
        }
        {
          name: 'Subnet1_s'
          type: 'string'
        }
        {
          name: 'SubnetRegion1_s'
          type: 'string'
        }
        {
          name: 'SecondarybytesIn_d'
          type: 'real'
        }
        {
          name: 'SecondarybytesOut_d'
          type: 'real'
        }
        {
          name: 'State_s'
          type: 'string'
        }
        {
          name: 'VlanId_d'
          type: 'real'
        }
        {
          name: 'SchemaVersion_s'
          type: 'string'
        }
        {
          name: 'Name_s'
          type: 'string'
        }
        {
          name: 'Region_s'
          type: 'string'
        }
        {
          name: 'Network_s'
          type: 'string'
        }
        {
          name: 'SecondaryPeerAddressPrefix_s'
          type: 'string'
        }
        {
          name: 'PrimaryNextHop_s'
          type: 'string'
        }
        {
          name: 'Weight_d'
          type: 'real'
        }
        {
          name: 'ComponentType_s'
          type: 'string'
        }
        {
          name: 'DiscoveryRegion_s'
          type: 'string'
        }
        {
          name: 'ResourceType'
          type: 'string'
        }
        {
          name: 'Status_s'
          type: 'string'
        }
        {
          name: 'SubType_s'
          type: 'string'
        }
        {
          name: 'Subscription_g'
          type: 'string'
        }
        {
          name: 'SubscriptionName_s'
          type: 'string'
        }
        {
          name: 'SecondaryNextHop_s'
          type: 'string'
        }
        {
          name: 'Subnet2_s'
          type: 'string'
        }
        {
          name: 'SecondaryAzurePort_s'
          type: 'string'
        }
        {
          name: 'PrimarybytesIn_d'
          type: 'real'
        }
        {
          name: 'SubnetRegion2_s'
          type: 'string'
        }
        {
          name: 'VirtualAppliances_s'
          type: 'string'
        }
        {
          name: 'BackendIPAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'BackendAddressPool_s'
          type: 'string'
        }
        {
          name: 'BackendPort_d'
          type: 'real'
        }
        {
          name: 'FloatingIPEnabled_b'
          type: 'string'
        }
        {
          name: 'FrontendIPAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'FrontendPort_d'
          type: 'real'
        }
        {
          name: 'PrimarybytesOut_d'
          type: 'real'
        }
        {
          name: 'Protocol_s'
          type: 'string'
        }
        {
          name: 'ServiceProviderProperties_s'
          type: 'string'
        }
        {
          name: 'ServiceProviderProvisioningState_s'
          type: 'string'
        }
        {
          name: 'SkuDetail_s'
          type: 'string'
        }
        {
          name: 'AzureASN_d'
          type: 'real'
        }
        {
          name: 'PeerASN_d'
          type: 'real'
        }
        {
          name: 'PeeringType_s'
          type: 'string'
        }
        {
          name: 'PrimaryAzurePort_s'
          type: 'string'
        }
        {
          name: 'PrimaryPeerAddressPrefix_s'
          type: 'string'
        }
        {
          name: 'CircuitProvisioningState_s'
          type: 'string'
        }
        {
          name: 'TimeProcessed_t'
          type: 'dateTime'
        }
        {
          name: 'ApplicationGatewayBackendPools_s'
          type: 'string'
        }
        {
          name: 'SourceAddressPrefix_s'
          type: 'string'
        }
        {
          name: 'NetworkFlowType_s'
          type: 'string'
        }
        {
          name: 'SrcIP_s'
          type: 'string'
        }
        {
          name: 'DestIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'VMIP_s'
          type: 'string'
        }
        {
          name: 'L4Protocol_s'
          type: 'string'
        }
        {
          name: 'IsFlowCapturedAtUDRHop_b'
          type: 'string'
        }
        {
          name: 'NSGList_s'
          type: 'string'
        }
        {
          name: 'NSGRules_s'
          type: 'string'
        }
        {
          name: 'FlowEndTime_t'
          type: 'dateTime'
        }
        {
          name: 'NSGRule_s'
          type: 'string'
        }
        {
          name: 'Subscription1_g'
          type: 'string'
        }
        {
          name: 'Subscription2_g'
          type: 'string'
        }
        {
          name: 'Region1_s'
          type: 'string'
        }
        {
          name: 'Region2_s'
          type: 'string'
        }
        {
          name: 'NIC_s'
          type: 'string'
        }
        {
          name: 'NIC1_s'
          type: 'string'
        }
        {
          name: 'NIC2_s'
          type: 'string'
        }
        {
          name: 'VM_s'
          type: 'string'
        }
        {
          name: 'NSGRuleType_s'
          type: 'string'
        }
        {
          name: 'VM1_s'
          type: 'string'
        }
        {
          name: 'FlowStartTime_t'
          type: 'dateTime'
        }
        {
          name: 'FlowIntervalStartTime_t'
          type: 'dateTime'
        }
        {
          name: 'PublicIPs_s'
          type: 'string'
        }
        {
          name: 'FlowStatus_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'FlowDirection_s'
          type: 'string'
        }
        {
          name: 'FlowType_s'
          type: 'string'
        }
        {
          name: 'SrcPublicIPs_s'
          type: 'string'
        }
        {
          name: 'L7Protocol_s'
          type: 'string'
        }
        {
          name: 'DestPublicIPs_s'
          type: 'string'
        }
        {
          name: 'FlowIntervalEndTime_t'
          type: 'dateTime'
        }
        {
          name: 'DestPort_d'
          type: 'real'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'FlowEndTime_s'
          type: 'string'
        }
        {
          name: 'FlowStartTime_s'
          type: 'string'
        }
        {
          name: 'Subscription2_s'
          type: 'string'
        }
        {
          name: 'Subscription1_s'
          type: 'string'
        }
        {
          name: 'FASchemaVersion_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'SourcePortRange_s'
          type: 'string'
        }
        {
          name: 'VM2_s'
          type: 'string'
        }
        {
          name: 'Routes_s'
          type: 'string'
        }
        {
          name: 'CompletedFlows_d'
          type: 'real'
        }
        {
          name: 'batchSizeInBytes_d'
          type: 'real'
        }
        {
          name: 'Priority_d'
          type: 'real'
        }
        {
          name: 'Tags_s'
          type: 'string'
        }
        {
          name: 'VmssName_s'
          type: 'string'
        }
        {
          name: 'AddressPrefixes_s'
          type: 'string'
        }
        {
          name: 'RouteTable_s'
          type: 'string'
        }
        {
          name: 'AddressPrefix_s'
          type: 'string'
        }
        {
          name: 'OutboundBytes_d'
          type: 'real'
        }
        {
          name: 'NextHopIP_s'
          type: 'string'
        }
        {
          name: 'FlowLogStorageAccount_s'
          type: 'string'
        }
        {
          name: 'IsFlowEnabled_b'
          type: 'string'
        }
        {
          name: 'Access_s'
          type: 'string'
        }
        {
          name: 'Description_s'
          type: 'string'
        }
        {
          name: 'DestinationAddressPrefix_s'
          type: 'string'
        }
        {
          name: 'DestinationPortRange_s'
          type: 'string'
        }
        {
          name: 'Direction_s'
          type: 'string'
        }
        {
          name: 'RuleType_s'
          type: 'string'
        }
        {
          name: 'NextHopType_s'
          type: 'string'
        }
        {
          name: 'Subnet_s'
          type: 'string'
        }
        {
          name: 'InboundBytes_d'
          type: 'real'
        }
        {
          name: 'InboundPackets_d'
          type: 'real'
        }
        {
          name: 'ApplicationGateway1_s'
          type: 'string'
        }
        {
          name: 'ApplicationGateway2_s'
          type: 'string'
        }
        {
          name: 'LoadBalancer1_s'
          type: 'string'
        }
        {
          name: 'LoadBalancer2_s'
          type: 'string'
        }
        {
          name: 'LocalNetworkGateway1_s'
          type: 'string'
        }
        {
          name: 'LocalNetworkGateway2_s'
          type: 'string'
        }
        {
          name: 'ExpressRouteCircuit1_s'
          type: 'string'
        }
        {
          name: 'ExpressRouteCircuit2_s'
          type: 'string'
        }
        {
          name: 'OutboundPackets_d'
          type: 'real'
        }
        {
          name: 'ExpressRouteCircuitPeeringType_s'
          type: 'string'
        }
        {
          name: 'ConnectingVNets_s'
          type: 'string'
        }
        {
          name: 'Country_s'
          type: 'string'
        }
        {
          name: 'AzureRegion_s'
          type: 'string'
        }
        {
          name: 'AllowedInFlows_d'
          type: 'real'
        }
        {
          name: 'DeniedInFlows_d'
          type: 'real'
        }
        {
          name: 'AllowedOutFlows_d'
          type: 'real'
        }
        {
          name: 'DeniedOutFlows_d'
          type: 'real'
        }
        {
          name: 'FlowCount_d'
          type: 'real'
        }
        {
          name: 'ConnectionName_s'
          type: 'string'
        }
        {
          name: 'TopologyVersion_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = azurenetworkanalyticsclTable.name
output tableId string = azurenetworkanalyticsclTable.id
output provisioningState string = azurenetworkanalyticsclTable.properties.provisioningState
