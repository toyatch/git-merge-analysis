require_relative 'git_log/parser'
require_relative 'git_log/files'
require_relative 'git_log/date'

class GitLog
  include GitLog::Parser
  include GitLog::Files
  include GitLog::Date

  def initialize(line)
    @line = line
  end

  def match(regexp)
    @line.match(regexp)
  end

  def strip
    @line.strip
  end

  def to_s
    @line.to_s
  end
end
