require 'bundler'
Bundler::GemHelper.install_tasks

task :clean do
  system "test -f ext/Makefile && make -C ext clean"
  system "rm -rf ext/Makefile ext/conftest.dSYM"
end

task :compile do
  system "cd ext; ruby extconf.rb && make check"
end

task :demo do
  Dir['samples/*.rb'].each {|f| system "ruby #{f}" }
end
