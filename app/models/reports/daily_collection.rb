class DailyCollection < Report
  self.table_name = "REPORTS.DW_DAILY_COLLECTION"
  #self.primary_key = "trn_id"

  


  def self.daily_collection
	query = <<-SQL 
		SELECT
		    TO_CHAR( PROCESSED_DATE, 'Mon-yyyy' ) PROCESSED_MONTH,
		    ROUND((sum( PAYMENT_AMOUNT ) + sum( CREDIT ))  /1000000000,2)                PAYMENT_AMOUNT
		FROM REPORTS.DAILY_COLLECTION --WHERE to_char(PROCESSED_DATE,'yyyymm')='202007'
		--WHERE to_char(PROCESSED_DATE,'yyyymm') BETWEEN '201907' AND '202006'
		WHERE PROCESSED_DATE BETWEEN to_date('20190701','yyyymmdd') AND to_date('20200630','yyyymmdd')
		GROUP BY TO_CHAR( PROCESSED_DATE, 'Mon-yyyy' ), TO_CHAR( PROCESSED_DATE, 'yyyymm' )
		ORDER BY TO_CHAR( PROCESSED_DATE, 'yyyymm' )
	SQL
	result = Report.connection.exec_query(query)
  end
end 
