require 'set'

class Parser
  attr_reader :log_file, :result

  def initialize(log_file, &formatter)
    @log_file = log_file
    @formatter = formatter
    @result = {}
  end

  def parse!
    Logger.log("parsing! ....")
    File.foreach(log_file) do |line|
      site, ip = line.split(' ')
      @result[site] = log_entry(site, ip, @result[site])
    end

    self
  end

  def ordered
    @formatter.call(self)
  end

  private

  def log_entry(site, ip, entry)
    if entry
      {
        unique_count: entry[:ips].add?(ip) ? entry[:unique_count] + 1 : entry[:unique_count],
        all_count: entry[:all_count] + 1,
        ips: entry[:ips]
      }
    else
      {
        unique_count: 1,
        all_count: 1,
        ips: Set.new([ip]),
      }
    end
  end
end
