class Merge
  def self.header
    [
      :commit,
      :merged_at,
      :leadtime,
      :files,
      :insertions,
      :deletions,
      :times,
      :comment
    ]
  end

  def initialize(commit, from)
    @status = {}
    @status[:commit] = commit
    @status[:from] = from
  end

  [
    :commit, :from,
    :merged_at, :comment,
    :start_at, :times,
    :files, :insertions, :deletions,
  ].each do |attribute|
    define_method(attribute) { @status[attribute] }
    define_method("#{attribute}=") { |value| @status[attribute] = value }
  end

  def leadtime
    (merged_at && start_at) ? (merged_at - start_at) : nil
  end

  def join(delimiter)
    row.join(delimiter)
  end

  private

  def extract(*attributes)
    attributes.map { |attribute| send(attribute) }
  end

  def row
    extract(*self.class.header)
  end
end
