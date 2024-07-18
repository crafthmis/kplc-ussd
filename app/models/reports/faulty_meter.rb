class FaultyMeter < Report
  self.table_name = "REPORTS.DW_FAULTY_METERS"
  #self.primary_key = "trn_id"

  


  def self.faulty_meters
	query = <<-SQL 
		select region,number_of_meters,resolved,number_pending from reports.dw_faulty_meters
		where end_date = (select max(end_date) from reports.dw_faulty_meters)
	SQL
	result = Report.connection.exec_query(query)
  end
end 


















