require 'bundler'
Bundler::GemHelper.install_tasks
Bundler::GemHelper.class_eval do
  remove_method :rubygem_push
  def rubygem_push(path)
    sh("curl -s -S -F file=@#{path} http://gems.xing.com/upload")
    Bundler.ui.confirm "Pushed #{name} #{version} to gems.xing.com"
  end
end
Rake::Task['release'].comment.to_s.sub!('Rubygems', "gems.xing.com")

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

task :default => :compile
