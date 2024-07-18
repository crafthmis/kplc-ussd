class DailyPurchase < Report
  self.table_name = "REPORTS.DW_DAILY_ENERGY_PUCHASE"
  #self.primary_key = "trn_id"


  


  def self.daily_energy_purchase
	query = <<-SQL 
		SELECT
		SOURCE            LABEL,
		sum( UNITS_KWH )  VALUE,
		'Units Purchased' SERIES,
		'green' AS        COLOR
		FROM REPORTS.DW_DAILY_ENERGY_PUCHASE DDEP
		WHERE SUMMARY_DATE BETWEEN '20200705' and '20200716'
		GROUP BY SOURCE
		UNION
		SELECT
		SOURCE                LABEL,
		sum( ESTIMATED_COST ) VALUE,
		'Estimated Costs'     SERIES,
		'orange' AS           COLOR
		FROM REPORTS.DW_DAILY_ENERGY_PUCHASE DDEP
		WHERE SUMMARY_DATE BETWEEN '20200705' and '20200716'
		GROUP BY SOURCE
	SQL
	result = Report.connection.exec_query(query)
  end
end 


















