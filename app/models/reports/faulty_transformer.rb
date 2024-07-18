class FaultyTransformer < Report
  self.table_name = "REPORTS.DW_FAULTY_TXS"
  #self.primary_key = "trn_id"

  


  def self.weekly_trend
	query = <<-SQL 
		select week_date Week,sum(FAILED_TXS) Transformer_failures
		FROM REPORTS.DW_FAULTY_TXS
		group by week_date
		order by week_date
	SQL
	result = Report.connection.exec_query(query)
  end


  def self.weekly_trend_per_region
  	query = <<-SQL
  		SELECT REGION, FAILED_TXS
  		FROM REPORTS.DW_FAULTY_TXS
  		where week_date='week 2' 
    SQL
	result = Report.connection.exec_query(query)
  end

  def self.faulty_transformers
    query = <<-SQL
      SELECT REGION, CUMULATIVE_TOTAL,WEEKLY_TOTAL,NEW_CUMULATIVE_TOTAL,BALANCE_BROUGHT_FORWARD,FAILED_TXS,REPLACED, BALANCE_CARRIED_FORWARD
      FROM REPORTS.DW_FAULTY_TXS where date_done=(select max(date_done)FROM REPORTS.DW_FAULTY_TXS)
	  SQL
	result = Report.connection.exec_query(query)
  end

  def self.weekly_transformer_failure  ##same as above
    query = <<-SQL
      SELECT REGION, CUMULATIVE_TOTAL,WEEKLY_TOTAL,NEW_CUMULATIVE_TOTAL,BALANCE_BROUGHT_FORWARD,FAILED_TXS,REPLACED, BALANCE_CARRIED_FORWARD
      FROM REPORTS.DW_FAULTY_TXS where date_done=(select max(date_done)FROM REPORTS.DW_FAULTY_TXS)
    SQL
   result = Report.connection.exec_query(query)
  end




end 
