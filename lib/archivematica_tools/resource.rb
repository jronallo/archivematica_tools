module ArchivematicaTools
  class Resource
    
    attr_accessor :package_filename, :mimetypes, :checksum, :date_modified, :relationship_subtype,
      :original_filepath
    
    def initialize(digiprov)
      @digiprov = digiprov
      process
    end
    
    private
    
    def process
      get_package_filename
      get_original_filepath
      get_mimetypes
      get_checksum
      get_date_modified
      get_relationship_subtype
    end
    
    def get_original_filepath
      @original_filepath = @digiprov.xpath(".//object/originalName").text
    end
    
    def get_package_filename
      @package_filename = @digiprov["ID"]
    end
    
    def get_mimetypes
      @mimetypes = []
      @digiprov.xpath(".//f:identification/f:identity", "f" => "http://hul.harvard.edu/ois/xml/ns/fits/fits_output").each do |identity|
        @mimetypes << identity['mimetype']
      end
      @mimetypes.uniq
    end
    
    def get_checksum
      @checksum = @digiprov.xpath('.//messageDigest').first.text()
    end
    
    def get_date_modified
      fslastmodified = @digiprov.xpath('.//f:fits//f:fslastmodified', "f" => "http://hul.harvard.edu/ois/xml/ns/fits/fits_output").first
      if fslastmodified
        @date_modified = Time.at(fslastmodified.text.to_i/1000) 
      end
    end
    
    def get_relationship_subtype
      if !@digiprov.xpath(".//relationship/relationshipSubType[contains(text(), 'has source')]").empty?
        @relationship_subtype = 'has source'
      else !@digiprov.xpath(".//relationship/relationshipSubType[contains(text(), 'is source of')]").empty?
        @relationship_subtype = "is source of"
      end
    end
    
    # Time.at(1296932258000/1000)
    
  end
end