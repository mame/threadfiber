Gem::Specification.new do |s|
  s.name = %q{threadfiber}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Yusuke Endoh"]
  s.date = %q{2008-08-24}
  s.description = %q{ThreadFiber is an implementation of fiber using threads.}
  s.email = ["mame@tsg.ne.jp"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/threadfiber.rb", "test/test_threadfiber.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/mame/threadfiber/tree/master}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{threadfiberx}
  s.rubygems_version = %q{1.2.0.1824}
  s.summary = %q{ThreadFiber is an implementation of fiber using threads.}
  s.test_files = ["test/test_threadfiber.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
