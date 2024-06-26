
module Spreedly

  class Gateway < Model

    field :gateway_type, :state, :name, :description
    attr_reader :credentials

    def initialize(xml_doc)
      super
      init_credentials(xml_doc)
    end

    def self.new_list_from(xml_doc)
      gateways = xml_doc.xpath('.//gateways/gateway')
      gateways.map do |each|
        self.new(each)
      end
    end

    private
    def init_credentials(xml_doc)
      @credentials = {}

      xml_doc.xpath('.//credentials/credential').each do |each|
        @credentials[each.at_xpath('.//name').text] = each.at_xpath('.//value').text
      end
    end

  end

end
