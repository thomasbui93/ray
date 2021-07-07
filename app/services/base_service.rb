# frozen_string_literal: true

class BaseService
  def self.call(*args, &block)
    new(*args, &block).execute
  end

  def execute
    raise NotImplementedError('You need to implement execute method')
  end
end
