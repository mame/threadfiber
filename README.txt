= threadfiber

* http://github.com/mame/threadfiber/tree/master

== DESCRIPTION:

ThreadFiber is an implementation of fiber using threads.

== FEATURES/PROBLEMS:


== SYNOPSIS:

require "threadfiber"

f = ThreadFiber.new do
  p :foo
  Fiber.yield
  p :bar
end

f.resume  #=> :foo
f.resume  #=> :bar

== REQUIREMENTS:

None

== INSTALL:

* gem install mame-threadfiber

== LICENSE:

Copyright:: Yusuke Endoh <mame@tsg.ne.jp>
License:: Ruby's
