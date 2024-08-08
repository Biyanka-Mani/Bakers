module DateHelper
  def self.normalize_date(start_date, end_date)
    start_date = start_date.present? ? Date.parse(start_date) : nil
    end_date = end_date.present? ? Date.parse(end_date) : nil

    if start_date.present? && start_date < 1.year.ago.to_date
      start_date = 1.year.ago.to_date
    end

    if end_date.present? && end_date > Date.today
      end_date = Date.today
    end

    [start_date, end_date]
  end
end
