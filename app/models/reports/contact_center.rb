class ContactCenter < Report
  self.table_name = "REPORTS.DW_CONTACT_CENTER_DATA_FINAL"
  #self.primary_key = "trn_id"

  

  def self.weekly_sale_vs_target
  	query = <<-SQL 
		SELECT
		    REGION,ROUND(SUM(total_bill),2) bill, ROUND(max(target),2) target,
		    ROUND(SUM(total_bill),2)-     ROUND(max(target),2) variance
		    from DW_POSTPAID_AMOUNTS_WEEKLY 
		    where billing_date between '20200705' and '20200716' and  REGION <>'UNMAPPED'
		    group by REGION;
    SQL
	result = Report.connection.exec_query(query)
  end
end 
