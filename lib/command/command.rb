class Command
  attr_reader :context

  def initialize(context = nil, description = nil)
    @context = context
    @description = description || "#{self.class} command"
  end

  def execute
    raise NotImplementedError
  end
end
