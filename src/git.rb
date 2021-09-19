require_relative 'git_log'
module Git
  def log_merges
    build_log { `git log --merges -m --name-status` }
  end

  def diff_stat(commited, branch)
    build_log { `git diff -w --stat #{branch} #{commited}` }
  end

  def commits(commited, branch)
    build_log { `git log --no-merges #{branch}..#{commited}` }
  end

  private

  def build_log
    yield.split("\n").map { |log| GitLog.new(log) }
  end
end
