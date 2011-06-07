require 'spec_helper'

describe ArchivematicaTools::Resource do

  before(:all) do
    @r1 = @p.resources.first
  end
  
  it "should have an original filepath" do
    @r1.original_filepath.should == "objects/Video/0239.mpg"
  end

  it "should have a filename from the package" do
    @r1.package_filename.should == "digiprov-0239.mpg-082d0e3f-50e4-4f8a-b305-0bc0910cba11"
  end
  
  it "should have a mimetype" do
    @r1.mimetypes.first.should == 'video/mpeg'
  end
  
  it "should have a checksum" do
    @r1.checksum.should == 'b794e283d7f6552717a7311f13bdbedc84945caca7b0203b212c71542a1beb1b'
  end
  
  it "should have a date_modified" do
    @r1.date_modified.to_s.should == "Sat Feb 05 13:57:38 -0500 2011"
  end
  
  it "should have a Time as the date_modified" do
    @r1.date_modified.should be_a Time
  end
  
  it "should have a relationship_subtype" do
    @r1.relationship_subtype.should == "is source of"
  end

end