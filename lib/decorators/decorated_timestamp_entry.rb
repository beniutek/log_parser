module DecoratedTimestampEntry
  def compose_header
    "timestamp,#{super}"
  end

  def compose_line(line)
    Logger.log("decorated timestamp is composing the line")
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    "#{timestamp},#{super(line)}"
  end
end
