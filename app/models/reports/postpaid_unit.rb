class PostpaidUnit < Report
  self.table_name = "REPORTS.DW_POSTPAID_UNIT_SALES_WEEKLY "
  #self.primary_key = "trn_id"

  


  def self.weekly_sale_vs_target
	query = <<-SQL 
	    SELECT
	    REGION,ROUND(SUM(units),2) units, ROUND(max(target),2) target,
	    ROUND(SUM(units),2)-     ROUND(max(target),2) variance
	    from REPORTS.DW_POSTPAID_UNIT_SALES_WEEKLY 
	    where billing_date between '20200705' and '20200716' and  REGION <>'UNMAPPED'
	    group by REGION
   SQL
	result = Report.connection.exec_query(query)
  end


end 




