module ArchivematicaTools
  class Package
    
    attr_accessor :identifier, :resources, :derivatives
    
    def initialize(mets_doc)
      if mets_doc.is_a? String
        @mets = Nokogiri::XML(mets_doc)
      elsif mets_doc.is_a? Nokogiri::XML::Document
        @mets = mets_doc
      elsif mets_doc.respond_to? :read
        @mets = Nokogiri::XML(mets_doc)
      end
      @resources = []
      @derivatives = []
      process
    end
    
    private
    
    def process
      get_identifier
      get_resources      
    end
    
    def get_identifier
      @identifier = @mets.xpath("//fileGrp[@USE='Objects package']").first['ID']
    end
    
    def get_resources
      @mets.xpath("//digiprovMD").each do |digiprov|
        r = Resource.new(digiprov)
        @resources << r if r.relationship_subtype == 'is source of'
        @derivatives << r if r.relationship_subtype == 'has source'
      end
    end
    
  end
end