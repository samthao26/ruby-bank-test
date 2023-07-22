require 'csv'

class CSVWriter

  def initialize(csv_filename)
    @csv_filename = csv_filename
    @f = File.open("./#{csv_filename}", 'w')
  end

  def append_arr(arr)
    arr.each do |e|
      append(e)
    end
  end

  def append(data)
    @f.write(data.to_csv)
  end

  def close
    @f.close
  end
end
