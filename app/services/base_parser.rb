class BaseParser
  def initialize(file:, file_parser: CsvParser.new)
    @file = file
    @file_parser = file_parser
  end

  def call
    file_parser.parse(file)
  end

  private
    attr_reader :file, :file_parser
end
