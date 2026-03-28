@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for AzureNetworkAnalytics_CL
// ============================================================================
// Generated: 2025-09-19 14:19:55
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 178, DCR columns: 176 (Type column always filtered)
// Output stream: Custom-AzureNetworkAnalytics_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-AzureNetworkAnalytics_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-AzureNetworkAnalytics_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'Peer_s'
            type: 'string'
          }
          {
            name: 'RoutingWeight_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'EgressBytesTransferred_d'
            type: 'string'
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
          }
          {
            name: 'PublicIPAddresses_s'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'SecondarybytesOut_d'
            type: 'string'
          }
          {
            name: 'State_s'
            type: 'string'
          }
          {
            name: 'VlanId_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
          }
          {
            name: 'BackendAddressPool_s'
            type: 'string'
          }
          {
            name: 'BackendPort_d'
            type: 'string'
          }
          {
            name: 'FloatingIPEnabled_b'
            type: 'string'
          }
          {
            name: 'FrontendIPAddress_s'
            type: 'string'
          }
          {
            name: 'FrontendPort_d'
            type: 'string'
          }
          {
            name: 'PrimarybytesOut_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'PeerASN_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'FlowIntervalStartTime_t'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'DestPort_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'batchSizeInBytes_d'
            type: 'string'
          }
          {
            name: 'Priority_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'InboundPackets_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'DeniedInFlows_d'
            type: 'string'
          }
          {
            name: 'AllowedOutFlows_d'
            type: 'string'
          }
          {
            name: 'DeniedOutFlows_d'
            type: 'string'
          }
          {
            name: 'FlowCount_d'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-AzureNetworkAnalytics_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-AzureNetworkAnalytics_CL']
        destinations: ['Sentinel-AzureNetworkAnalytics_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), Peer_s = tostring(Peer_s), RoutingWeight_d = toreal(RoutingWeight_d), VirtualNetworkGateway1_s = tostring(VirtualNetworkGateway1_s), VirtualNetworkGateway2_s = tostring(VirtualNetworkGateway2_s), AllowForwardedTraffic_b = tostring(AllowForwardedTraffic_b), AllowGatewayTransit_b = tostring(AllowGatewayTransit_b), AllowVirtualNetworkAccess_b = tostring(AllowVirtualNetworkAccess_b), UseRemoteGateways_b = tostring(UseRemoteGateways_b), LocalNetworkGateway_s = tostring(LocalNetworkGateway_s), VirtualNetwork1_s = tostring(VirtualNetwork1_s), AppGatewayType_s = tostring(AppGatewayType_s), GatewaySubnet_s = tostring(GatewaySubnet_s), PrivateFrontendIPs_s = tostring(PrivateFrontendIPs_s), PublicFrontendIPs_s = tostring(PublicFrontendIPs_s), BackendSubnets_s = tostring(BackendSubnets_s), FrontendIPs_s = tostring(FrontendIPs_s), FrontendSubnet_s = tostring(FrontendSubnet_s), FrontendSubnets_s = tostring(FrontendSubnets_s), VirtualNetwork2_s = tostring(VirtualNetwork2_s), LoadBalancerType_s = tostring(LoadBalancerType_s), IngressBytesTransferred_d = toreal(IngressBytesTransferred_d), EgressBytesTransferred_d = toreal(EgressBytesTransferred_d), LoadBalancerBackendPools_s = tostring(LoadBalancerBackendPools_s), MACAddress_s = tostring(MACAddress_s), NSG_s = tostring(NSG_s), PrivateIPAddresses_s = tostring(PrivateIPAddresses_s), PublicIPAddresses_s = tostring(PublicIPAddresses_s), Subnetwork_s = tostring(Subnetwork_s), VirtualMachine_s = tostring(VirtualMachine_s), IsVirtualAppliance_b = tostring(IsVirtualAppliance_b), GatewayConnectionType_s = tostring(GatewayConnectionType_s), IPAddress = tostring(IPAddress), BGPEnabled_b = tostring(BGPEnabled_b), GatewayType_s = tostring(GatewayType_s), SKU_s = tostring(SKU_s), VIPAddress_s = tostring(VIPAddress_s), VirtualSubnetwork_s = tostring(VirtualSubnetwork_s), VpnClientAddressPrefixes_s = tostring(VpnClientAddressPrefixes_s), ConnectionStatus_s = tostring(ConnectionStatus_s), ConnectionType_s = tostring(ConnectionType_s), SubnetPrefixes_s = tostring(SubnetPrefixes_s), EnableIPForwarding_b = tostring(EnableIPForwarding_b), Subnet1_s = tostring(Subnet1_s), SubnetRegion1_s = tostring(SubnetRegion1_s), SecondarybytesIn_d = toreal(SecondarybytesIn_d), SecondarybytesOut_d = toreal(SecondarybytesOut_d), State_s = tostring(State_s), VlanId_d = toreal(VlanId_d), SchemaVersion_s = tostring(SchemaVersion_s), Name_s = tostring(Name_s), Region_s = tostring(Region_s), Network_s = tostring(Network_s), SecondaryPeerAddressPrefix_s = tostring(SecondaryPeerAddressPrefix_s), PrimaryNextHop_s = tostring(PrimaryNextHop_s), Weight_d = toreal(Weight_d), ComponentType_s = tostring(ComponentType_s), DiscoveryRegion_s = tostring(DiscoveryRegion_s), ResourceType = tostring(ResourceType), Status_s = tostring(Status_s), SubType_s = tostring(SubType_s), Subscription_g = tostring(Subscription_g), SubscriptionName_s = tostring(SubscriptionName_s), SecondaryNextHop_s = tostring(SecondaryNextHop_s), Subnet2_s = tostring(Subnet2_s), SecondaryAzurePort_s = tostring(SecondaryAzurePort_s), PrimarybytesIn_d = toreal(PrimarybytesIn_d), SubnetRegion2_s = tostring(SubnetRegion2_s), VirtualAppliances_s = tostring(VirtualAppliances_s), BackendIPAddress_s = tostring(BackendIPAddress_s), BackendAddressPool_s = tostring(BackendAddressPool_s), BackendPort_d = toreal(BackendPort_d), FloatingIPEnabled_b = tostring(FloatingIPEnabled_b), FrontendIPAddress_s = tostring(FrontendIPAddress_s), FrontendPort_d = toreal(FrontendPort_d), PrimarybytesOut_d = toreal(PrimarybytesOut_d), Protocol_s = tostring(Protocol_s), ServiceProviderProperties_s = tostring(ServiceProviderProperties_s), ServiceProviderProvisioningState_s = tostring(ServiceProviderProvisioningState_s), SkuDetail_s = tostring(SkuDetail_s), AzureASN_d = toreal(AzureASN_d), PeerASN_d = toreal(PeerASN_d), PeeringType_s = tostring(PeeringType_s), PrimaryAzurePort_s = tostring(PrimaryAzurePort_s), PrimaryPeerAddressPrefix_s = tostring(PrimaryPeerAddressPrefix_s), CircuitProvisioningState_s = tostring(CircuitProvisioningState_s), TimeProcessed_t = todatetime(TimeProcessed_t), ApplicationGatewayBackendPools_s = tostring(ApplicationGatewayBackendPools_s), SourceAddressPrefix_s = tostring(SourceAddressPrefix_s), NetworkFlowType_s = tostring(NetworkFlowType_s), SrcIP_s = tostring(SrcIP_s), DestIP_s = tostring(DestIP_s), VMIP_s = tostring(VMIP_s), L4Protocol_s = tostring(L4Protocol_s), IsFlowCapturedAtUDRHop_b = tostring(IsFlowCapturedAtUDRHop_b), NSGList_s = tostring(NSGList_s), NSGRules_s = tostring(NSGRules_s), FlowEndTime_t = todatetime(FlowEndTime_t), NSGRule_s = tostring(NSGRule_s), Subscription1_g = tostring(Subscription1_g), Subscription2_g = tostring(Subscription2_g), Region1_s = tostring(Region1_s), Region2_s = tostring(Region2_s), NIC_s = tostring(NIC_s), NIC1_s = tostring(NIC1_s), NIC2_s = tostring(NIC2_s), VM_s = tostring(VM_s), NSGRuleType_s = tostring(NSGRuleType_s), VM1_s = tostring(VM1_s), FlowStartTime_t = todatetime(FlowStartTime_t), FlowIntervalStartTime_t = todatetime(FlowIntervalStartTime_t), PublicIPs_s = tostring(PublicIPs_s), FlowStatus_s = tostring(FlowStatus_s), Computer = tostring(Computer), FlowDirection_s = tostring(FlowDirection_s), FlowType_s = tostring(FlowType_s), SrcPublicIPs_s = tostring(SrcPublicIPs_s), L7Protocol_s = tostring(L7Protocol_s), DestPublicIPs_s = tostring(DestPublicIPs_s), FlowIntervalEndTime_t = todatetime(FlowIntervalEndTime_t), DestPort_d = toreal(DestPort_d), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), RawData = tostring(RawData), FlowEndTime_s = tostring(FlowEndTime_s), FlowStartTime_s = tostring(FlowStartTime_s), Subscription2_s = tostring(Subscription2_s), Subscription1_s = tostring(Subscription1_s), FASchemaVersion_s = tostring(FASchemaVersion_s), SourceSystem = tostring(SourceSystem), SourcePortRange_s = tostring(SourcePortRange_s), VM2_s = tostring(VM2_s), Routes_s = tostring(Routes_s), CompletedFlows_d = toreal(CompletedFlows_d), batchSizeInBytes_d = toreal(batchSizeInBytes_d), Priority_d = toreal(Priority_d), Tags_s = tostring(Tags_s), VmssName_s = tostring(VmssName_s), AddressPrefixes_s = tostring(AddressPrefixes_s), RouteTable_s = tostring(RouteTable_s), AddressPrefix_s = tostring(AddressPrefix_s), OutboundBytes_d = toreal(OutboundBytes_d), NextHopIP_s = tostring(NextHopIP_s), FlowLogStorageAccount_s = tostring(FlowLogStorageAccount_s), IsFlowEnabled_b = tostring(IsFlowEnabled_b), Access_s = tostring(Access_s), Description_s = tostring(Description_s), DestinationAddressPrefix_s = tostring(DestinationAddressPrefix_s), DestinationPortRange_s = tostring(DestinationPortRange_s), Direction_s = tostring(Direction_s), RuleType_s = tostring(RuleType_s), NextHopType_s = tostring(NextHopType_s), Subnet_s = tostring(Subnet_s), InboundBytes_d = toreal(InboundBytes_d), InboundPackets_d = toreal(InboundPackets_d), ApplicationGateway1_s = tostring(ApplicationGateway1_s), ApplicationGateway2_s = tostring(ApplicationGateway2_s), LoadBalancer1_s = tostring(LoadBalancer1_s), LoadBalancer2_s = tostring(LoadBalancer2_s), LocalNetworkGateway1_s = tostring(LocalNetworkGateway1_s), LocalNetworkGateway2_s = tostring(LocalNetworkGateway2_s), ExpressRouteCircuit1_s = tostring(ExpressRouteCircuit1_s), ExpressRouteCircuit2_s = tostring(ExpressRouteCircuit2_s), OutboundPackets_d = toreal(OutboundPackets_d), ExpressRouteCircuitPeeringType_s = tostring(ExpressRouteCircuitPeeringType_s), ConnectingVNets_s = tostring(ConnectingVNets_s), Country_s = tostring(Country_s), AzureRegion_s = tostring(AzureRegion_s), AllowedInFlows_d = toreal(AllowedInFlows_d), DeniedInFlows_d = toreal(DeniedInFlows_d), AllowedOutFlows_d = toreal(AllowedOutFlows_d), DeniedOutFlows_d = toreal(DeniedOutFlows_d), FlowCount_d = toreal(FlowCount_d), ConnectionName_s = tostring(ConnectionName_s), TopologyVersion_s = tostring(TopologyVersion_s)'
        outputStream: 'Custom-AzureNetworkAnalytics_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
