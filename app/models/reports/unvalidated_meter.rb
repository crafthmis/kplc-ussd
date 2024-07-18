class UnvalidatedMeter < Report
  self.table_name = "REPORTS.DW_UNVALIDATED_METERS"
  #self.primary_key = "trn_id"

  


  def self.unvalidated_meters
	query = <<-SQL 
		SELECT region, number_of_meters,number_installed,number_pending 
	    FROM reports.DW_UNVALIDATED_METERS
	    where end_date = (select max(end_date) from reports.DW_UNVALIDATED_METERS)
	SQL
	result = Report.connection.exec_query(query)
  end
end 
