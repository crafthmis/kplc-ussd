
module Scopeable 
  extend ActiveSupport::Concern



  def self.included(klass)
    klass.instance_eval do
     scope :created_today, -> { where(created_at: Time.now.beginning_of_day..Time.now.end_of_day) }
	 scope :created_one_week_ago, -> { where(created_at: 1.week.ago.midnight..Time.now.end_of_day) }
	 scope :having_created_at_between, ->(start_date, end_date) { where(created_at: start_date.beginning_of_day..end_date.end_of_day) }
    end
  end


end


