class GitLog
  module Parser
    def parse_marge_commit
      match(/\Acommit (.*) \(from (.*)\)/)&.to_a[1..2]
    end

    def label
      match(/\A(commit|Merge|Author|Date|\s+)/).to_a.first&.strip
    end
  end
end
