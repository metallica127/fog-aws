module Fog
  module Compute
    class AWS
      class Real
        require 'fog/aws/parsers/compute/create_vpc_peering_connection'

        # Creates a VPC peering connection
        #
        # ==== Parameters
        # * peerOwnerId - The AWS account ID of the owner of the peer VPC. Default: Your AWS account ID
        # * peerVpcId<~String> - The ID of the VPC with which you are creating the VPC peering connection
        # * vpcId<~String> - The ID of the requester VPC
        #
        # === Returns
        # * response<~Excon::Response>:
        # * body<~Hash>:
        # * 'requestId'<~String> - Id of request
        # * 'vpcPeeringConnection'<~Hash>:
        # *   'accepterVpcInfo'<~Hash>
        # *   'expirationTime'<~String>
        # *   'requesterVpcInfo'<~Hash>
        # *   'status'<~Hash>
        # *   'tagSet'<~Array>
        # *   'vpcPeeringConnectionId'<~String>
        # *
        # {Amazon API Reference}[http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpcPeeringConnection.html]

        def create_vpc_peering_connection(peerOwnerId='default',peerVpcId, vpcId)
          request(
             'Action' => 'CreateVpcPeeringConnection',
             'PeerOwnerId' => peerOwnerId,
             'PeerVpcId' => peerVpcId,
             'VpcId' => vpcId,
             :parser => Fog::Parsers::Compute::AWS::CreateVpcPeeringConnection.new
          )
        end

      end

      class Mock

        def create_vpc_peering_connection(peerOwnerId='default',peerVpcId, vpcId)

        end
      end

    end
  end
end


#http://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateVpcPeeringConnection.html