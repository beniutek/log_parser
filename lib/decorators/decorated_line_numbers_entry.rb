module DecoratedLineNumbersEntry
  def compose_line(line)
    Logger.log("decorated line number is composing the line: #{line}")
    @line_number = 1 unless @line_number
    tmp = @line_number
    @line_number += 1
    "#{tmp},#{super(line)}"
  end

  def compose_header
    "lp,#{super}"
  end
end
