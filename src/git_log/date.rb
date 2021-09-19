class GitLog
  module Date
    def date
      matched = match(/\ADate:\s+(.+) (.+) (\d+) (\d+):(\d+):(\d+) (\d+) (.+)/)&.to_a
      date_log, dt, mon, day, h, m , s, year, tz = matched
      date_log ? Time.new(year, mon, day, h, m, s, "#{tz[0,3]}:#{tz[-2,2]}") : nil
    end
  end
end
