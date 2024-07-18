class NewConnection < Report
  self.table_name = "REPORTS.DW_NEW_CONNECTIONS_PERIODS"
  #self.primary_key = "trn_id"

  


  def self.new_connection
	query = <<-SQL 
		SELECT to_char(to_date(period,'yyyymm'),'Mon')||'-'||substr(period,1,4) PP,SUM(NEW_CONNECTIONS) NEW_CONNECTIONS 
		FROM reports.DW_NEW_CONNECTIONS_PERIODS
		where period >= '201907' and period <= '202006'
		GROUP BY period
		order by period
	SQL
	result = Report.connection.exec_query(query)
  end

def converted_period
   	  Date.strptime(period.to_i.to_s,"%Y%m")
   end

end 
