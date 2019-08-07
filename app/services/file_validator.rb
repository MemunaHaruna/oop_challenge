class FileValidator
  @@VALID_FORMATS = [
    'text/csv',
    'application/vnd.ms-excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
  ]

  @@TYPE = {csv: 'csv', xls: 'xls'}

  class << self
    def call(file)
      set_format(file)
    end

    def get_format(file)
      if !@@VALID_FORMATS.include? file.content_type
        raise ExceptionHandler::InvalidFileFormat, 'Invalid file format'
      end
      file.content_type
    end

    def set_format(file)
      'xls' if get_format(file) == (@@VALID_FORMATS[1] || @@VALID_FORMATS[2])
    end

    def type
      HashWithIndifferentAccess.new(@@TYPE)
    end
  end
end
