# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wiki_lib}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Stott"]
  s.autorequire = %q{wiki_lib}
  s.date = %q{2008-11-16}
  s.description = %q{A simple library to wrap around some common wiki operations Currently only PMWiki is supported, but more will be added as and when.}
  s.email = %q{jonathan.stott@gmail.com}
  s.files = ["LICENSE", "README", "Rakefile", "lib/wiki_lib", "lib/wiki_lib/pm_wiki.rb", "lib/wiki_lib.rb", "spec/spec_helper.rb", "spec/wiki_lib_spec.rb"]
  s.homepage = %q{http://github.com/namelessjon/wiki-lib}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A simple library to wrap around some common wiki operations}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, ["~> 0.8"])
    else
      s.add_dependency(%q<mechanize>, ["~> 0.8"])
    end
  else
    s.add_dependency(%q<mechanize>, ["~> 0.8"])
  end
end
