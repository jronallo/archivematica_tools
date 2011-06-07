require 'rubygems'
require 'bundler/setup'

require 'archivematica_tools' # and any other gems you need

RSpec.configure do |config|
  config.before(:all) do
    @mets = File.read(File.join(File.dirname(__FILE__), 'examples', 'METS.xml'))     
    @p = ArchivematicaTools::Package.new(@mets)
  end
end