require 'spec_helper'

describe ArchivematicaTools::Package do
    
  it "should have an identifier" do
    @p.identifier.should == "sampleSIP-ac597c16-c47b-4ca2-aa3b-8629bd4c8a45"
  end
  
  it "should have a collection of resources" do
    @p.resources.length > 0
    @p.resources.first.is_a? ArchivematicaTools::Resource
  end
  
  it "should have the correct number of resources" do
    @p.resources.length.should == 14
  end
  
  it "should have the correct number of derivatives" do
    @p.derivatives.length.should == 11
  end
  
  it "can be created with a Nokogiri::Document" do
    doc = Nokogiri::XML(@mets)
    lambda{ArchivematicaTools::Package.new(doc)}.should_not raise_error
  end
  
  it "can be created with anything that responds to read" do
    file = File.open(File.join(File.dirname(__FILE__), '..', 'examples', 'METS.xml'), 'r')
    lambda{ArchivematicaTools::Package.new(file)}.should_not raise_error
  end
  
end