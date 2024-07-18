class PrepaidUnit < Report
  self.table_name = "REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES"
  #self.primary_key = "trn_id"

  


  def self.weekly_sale
	query = <<-SQL 
		SELECT
		REGION,ROUND(SUM(UNITS),2) units, ROUND(max(target),2) target,
		ROUND(SUM(UNITS),2)-     ROUND(max(target),2) variance
		from REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES 
		where p_period between '20200705' and '20200716' and  REGION <>'UNMAPPED'
		group by REGION
   SQL
	result = Report.connection.exec_query(query)
  end


end 