require 'mkmf'
$LDFLAGS = "-licuuc -licui18n -licudata -lstdc++ "
$CFLAGS = "-Wall"
if !have_library('icui18n', 'u_init_3_6')
  puts "ICU v3.6 required -- not found."
  exit 1
end
create_makefile('icu4r')
File.open("Makefile", "a") << <<-EOT

check:	$(DLLIB)
	@$(RUBY) $(srcdir)/test/test_ustring.rb 
	@$(RUBY) $(srcdir)/test/test_calendar.rb
	@$(RUBY) $(srcdir)/test/test_converter.rb
	@$(RUBY) $(srcdir)/test/test_collator.rb

EOT

# Below is an awful hack: I remove the clean target from the Makefile
#
# Rationale: The 'gem install icu4r...' compiles the sources fine, but
# does leave them inside the
# /opt/local/lib/ruby/gems/1.8/gems/icu4r-0.1.5.2007.05.06/, 
# i.e., the "make install" doesn't copy them somewhere else.
# So, when "make clean" is called directly afterwards, it removes the
# icu4r.bundle that is the result of the installation.
#
# The clean target itself is hardcoded in mkmf.rb, so it is always
# executed.
#
# The other option, modifying the install location, is bad because a "gem
# uninstall" would not work anymore.
# (When unpacking the gem and running "ruby extconf.rb" manually, the
# install location is in fact different (compare the Makefiles and you'll
# see different assignments of RUBYLIBDIR and RUBYARCHDIR).)
open('Makefile.new','w') { |g| g << open('Makefile') { |f| f.read }.gsub(/\nclean:\n[^\n]*\n/, "\nclean:\n") }
FileUtils.mv 'Makefile.new', 'Makefile'
