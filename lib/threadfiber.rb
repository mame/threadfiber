require "thread"

class ThreadFiber
  VERSION = "1.0.0"

  @@fibers = {}

  def initialize(&block)
    unless block_given?
      raise(ArgumentError, "tried to create Fiber without a block")
    end

    @resume_mutex = Mutex.new
    @switch_mutex = Mutex.new
    @switch_cond = ConditionVariable.new
    @arg, @exception, @dead = nil, nil, false
    @switch_mutex.synchronize do
      th = Thread.new do
        arg, exc = call_block(switch, &block)
        @switch_mutex.synchronize do
          @arg, @exception, @dead = arg, exc, true
          @switch_cond.signal
        end
        @@fibers.delete(Thread.current)
      end
      @@fibers[th] = self
      @switch_cond.wait(@switch_mutex)
    end
  end

  def call_block(arg, &block)
    [yield(arg), nil]
  rescue ThreadError
    case $!.message
    when "return can't jump across threads"
      [nil, LocalJumpError.new("unexpected return")]
    when /\Auncaught throw/
      [nil, ArgumentError.new($!.message)]
    else
      [nil, $!]
    end
  rescue Exception
    [nil, $!]
  end

  def switch(*args)
    @switch_mutex.synchronize do
      raise(FiberError, "dead fiber called") if @dead
      @arg = args.size <= 1 ? args.first : args
      @switch_cond.signal
      @switch_cond.wait(@switch_mutex)
      raise @exception if @exception
      @arg
    end
  end

  def resume(*args)
    if @resume_mutex.try_lock
      begin
        switch(*args)
      ensure
        @resume_mutex.unlock
      end
    else
      raise(FiberError, "double resume")
    end
  end

  def resume_wait(*args)
    @resume_mutex.synchronize { switch(*args) }
  end

  def self.yield(*args)
    fib = current
    raise(FiberError, "can't yield from root fiber") unless fib
    fib.switch(*args)
  end

  def self.current
    @@fibers[Thread.current]
  end

  def self.deploy
    Object.instance_eval do
      remove_const(:Fiber) if const_defined?(:Fiber)
      const_set(:Fiber, ThreadFiber)
    end
  end
end

unless defined?(FiberError)
  class FiberError < StandardError
  end
end
