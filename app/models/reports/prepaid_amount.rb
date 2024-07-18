class PrepaidAmount < Report
  self.table_name = "REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES"
  #self.primary_key = "trn_id"

  


  def self.weekly_sale_vs_target
  	query = <<-SQL 
		SELECT
		REGION,ROUND(SUM(amounts)/1000000,2) units, ROUND(max(target),2) target,
		ROUND(SUM(amounts)/1000000,2)-     ROUND(max(target),2) variance
		from DW_PREPAID_WEEKLY_AMOUNT_SALES 
		where p_period between '20200705' and '20200716' and  REGION <>'UNMAPPED'
		group by REGION
   SQL
	result = Report.connection.exec_query(query)
  end
end 