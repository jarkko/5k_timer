require 'csv'

module CsvImporter
  def self.import(file)
    reader = CSV.open(Rails.root.join('runners.csv'), 'r') do |row|
      p row
      number = row[0].strip
      first = row[3].strip
      last = row[4].strip
      category = Category.find_by_name(row[6].strip)
      attributes = {:bib_number => number, :first_name => first, :last_name => last, :category => category}
      if runner = Runner.find_by_bib_number(number)
        runner.update_attributes!(attributes)
      else
        Runner.create!(attributes)
      end
    end
  end
end