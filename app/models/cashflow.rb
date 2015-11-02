class Cashflow < ActiveRecord::Base

  attr_accessor :flow, :year

  def self.total_on(date)
    where("date(flow) = ?", date).sum(:year)
  end

end
