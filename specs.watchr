# from: http://www.dixis.com/?p=364
# adapted from http://github.com/rspec/rspec-rails/blob/master/specs.watchr

# Run me with:
#
#   $ watchr specs.watchr

# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------
def all_spec_files
  Dir['spec/**/*_spec.rb']
end

def run_spec_matching(thing_to_match)
  matches = all_spec_files.grep(/#{thing_to_match}/i)
  if matches.empty?
    puts "Sorry, thanks for playing, but there were no matches for #{thing_to_match}"
  else
    run matches.join(' ')
  end
end

def self.notify title, msg, img
  system "notify-send '#{title}' '#{msg}' -i #{img} -t 3000"
end

def run(files_to_run)
  image_root = "~/.autotest_images"
  puts("Running: #{files_to_run}")
  results=`rspec --color --tty #{files_to_run}`
  puts results
  puts "\n================\n"
  output = results.slice(/(\d+)\sexamples?,\s(\d+)\sfailures?/)
  failure = results.include? 'Failure'
  if failure
    notify "FAIL", "#{output}", "#{image_root}/fail.png"
  else
    notify "Pass", "#{output}", "#{image_root}/pass.png"
  end
  no_int_for_you
end

def run_all_specs
  run(all_spec_files.join(' '))
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch('^spec/(.*)_spec\.rb')    { |m| run_spec_matching(m[1]) }
watch('^app/(.*)\.rb')          { |m| run_spec_matching(m[1]) }
watch('^app/(.*)\.haml')        { |m| run_spec_matching(m[1]) }
watch('^lib/(.*)\.rb')          { |m| run_spec_matching(m[1]) }
watch('^spec/spec_helper\.rb')  { run_all_specs }
watch('^spec/support/.*\.rb')   { run_all_specs }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------

def no_int_for_you
  @sent_an_int = nil
end

Signal.trap 'INT' do
  if @sent_an_int then
    puts "   A second INT?  Ok, I get the message.  Shutting down now."
    exit
  else
    puts "   Did you just send me an INT? Ugh.  I'll quit for real if you do it again."
    @sent_an_int = true
    Kernel.sleep 1.5
    run_all_specs
  end
end

