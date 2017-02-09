module Fog
  module Parsers
    module Compute
      module AWS

        class CreateVpcPeeringConnection < Fog::Parsers::Base

          def reset
            @vpc_peering_connection = {
                'accepterVpcInfo' => {},
                'requesterVpcInfo' => {},
                'status' => {},
                'tagSet' => {}
            }
            @accepter_vpc_info = {}
            @response = {'vpcPeeringConnection' => {}}
            @tag = {}
          end

          def start_element(name, attrs = [])
            super
            case name
              when 'tagSet'
                @in_tag_set = true
              when 'accepterVpcInfo'
                @in_accepter_vpc_info = true
              when 'requesterVpcInfo'
                @in_requester_vpc_info = true
              when 'status'
                @in_status = true
            end
          end

          def end_element(name)
            if @in_tag_set
              case name
                when 'item'
                  @vpc_peering_connection['tagSet'][@tag['key']] = @tag['value'] #TODO
                  @tag = {}
                when 'key', 'value'
                  @tag[name] = value
                when 'tagSet'
                  @in_tag_set = false
              end

            elsif @in_accepter_vpc_info
              case name
                when 'ipv6CidrBlockSet'
                  puts 'FUUUUU ipv6CidrBlockSet'
                  @vpc_peering_connection['accepterVpcInfo'][name] = value
                when 'peeringOptions'
                  puts 'FUUUUU peeringOptions'
                  @vpc_peering_connection['accepterVpcInfo'][name] = value
                when 'cidrBlock', 'ownerId', 'vpcId'
                  @vpc_peering_connection['accepterVpcInfo'][name] = value
                  #@accepter_vpc_info[name] = value
                when 'accepterVpcInfo'
                  #@vpc_peering_connection['accepterVpcInfo'] = @accepter_vpc_info
                  #@accepter_vpc_info = {}
                  @in_accepter_vpc_info = false
              end
            elsif @in_requester_vpc_info
              case name
                when 'ipv6CidrBlockSet'
                  puts 'FUUUUU ipv6CidrBlockSet'
                  @vpc_peering_connection['requesterVpcInfo'][name] = value
                when 'peeringOptions'
                  puts 'FUUUUU peeringOptions'
                  @vpc_peering_connection['requesterVpcInfo'][name] = value
                when 'cidrBlock', 'ownerId', 'vpcId'
                  @vpc_peering_connection['requesterVpcInfo'][name] = value
                when 'requesterVpcInfo'
                  @in_requester_vpc_info = false
              end

            elsif @in_status
              case name
                when 'code','message'
                  @vpc_peering_connection['status'][name] = value
                when 'status'
                  @in_status = false
              end
            else
              #@response[name] = value

              case name
                when 'expirationTime', 'vpcPeeringConnectionId'
                  @vpc_peering_connection[name] = value
                when 'vpcPeeringConnection'
                  @response['vpcPeeringConnection'] = @vpc_peering_connection
                  @vpc_peering_connection = {'accepterVpcInfo' => {}, 'requesterVpcInfo' => {}, 'status' => {}, 'tagSet' => {}}
                when 'requestId'
                  @response[name] = value
              end

            end
          end

        end

      end
    end
  end
end
