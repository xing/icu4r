require 'mkmf'

if `uname -sp`.chomp =~ /Darwin/ && File.directory?("/usr/local/icu36/")
  $INCFLAGS <<  " -I/usr/local/icu36/include "
  $LIBPATH = ["/usr/local/icu36/lib"] | $LIBPATH
  $LOCAL_LIBS << " -licuuc -licui18n -licudata "
else
  $LDFLAGS << " -licuuc -licui18n -licudata -lstdc++"
end

if !have_func('u_init_3_6')
  puts "ICU v3.6 required -- not found."
  exit 1
end

create_makefile('icu4r')

File.open("Makefile", "a") << <<-EOT

check:	$(DLLIB)
	@$(RUBY) $(srcdir)/../test/test_ustring.rb
	@$(RUBY) $(srcdir)/../test/test_calendar.rb
	@$(RUBY) $(srcdir)/../test/test_converter.rb
	@$(RUBY) $(srcdir)/../test/test_collator.rb

EOT
