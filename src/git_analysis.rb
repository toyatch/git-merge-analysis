require_relative 'git'
require_relative 'merge'

module GitAnalysis
  extend Git
  def self.merge_analysis
    puts Merge.header.join("\t")

    merge = nil
    log_merges.each do |line|
      case line.label
      when "commit"
        puts merge.join("\t") if merge

        merge = Merge.new(*line.parse_marge_commit)

        commits_logs = commits(merge.commit, merge.from)
        timestamps = commits_logs.each_with_object([]) do |log, array|
          date_time = log.date
          array << date_time if date_time
        end
        merge.start_at = timestamps.last
        merge.times    = timestamps.count

        diff_stat_log = diff_stat(merge.commit, merge.from).last
        merge.files      = diff_stat_log.files
        merge.insertions = diff_stat_log.insertions
        merge.deletions  = diff_stat_log.deletions
      when "Date"
        merge.merged_at = line.date
      when ""
        merge.comment ||= line.strip # とりあえず1行目だけ
      end
    end
    puts merge.join("\t") if merge
  end
end
