class GitLog
  module Files
    def has_files?
      !!@line.match(/(\d+) files? changed.*/)
    end

    [ :files, :insertions, :deletions ].each do |attribute|
      define_method(attribute) do
        return nil unless has_files?
        match(/.* (\d+) #{attribute}?/).to_a.last.to_i rescue 0
      end
    end
  end
end
