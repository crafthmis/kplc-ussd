class Sale < Report
  self.table_name = "REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES"
  #self.primary_key = "trn_id"

  


  def self.amount_units
	query = <<-SQL 
		SELECT
		    'WEEKLY TOTAL UNITS (GWhrs)' LABEL,
		to_char(round(sum(units),2),'99,999.99') VALUE 
		from
		(
		select sum(units) units from REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES
		union
		select sum(units) unit from REPORTS.DW_POSTPAID_UNIT_SALES_WEEKLY) 

		union
		SELECT
		    'WEEKLY TOTAL AMOUNTS (Kshs(M))' LABEL,
		 to_char(round(sum(amounts),2),'9,999,999.99') VALUE from
		(
		select sum(amounts)/1000000 amounts from REPORTS.DW_PREPAID_WEEKLY_AMOUNT_SALES
		union
		select sum(total_bill) amounts from REPORTS.DW_POSTPAID_AMOUNTS_WEEKLY)

	SQL
	result = Report.connection.exec_query(query)
  end


  def self.weekly_total_amount_units
  	query = <<-SQL 
		SELECT
		    'WEEKLY TOTAL UNITS (GWhrs)' LABEL,
		to_char(round(sum(units),2),'99,999.99') VALUE 
		from
		(
		select sum(units) units from REPORTS.DW_PREPAID_WEEKLY_UNIT_SALES
		union
		select sum(units) unit from REPORTS.DW_POSTPAID_UNIT_SALES_WEEKLY) 

		union
		SELECT
		    'WEEKLY TOTAL AMOUNTS (Kshs(M))' LABEL,
		 to_char(round(sum(amounts),2),'9,999,999.99') VALUE from
		(
		select sum(amounts)/1000000 amounts from REPORTS.DW_PREPAID_WEEKLY_AMOUNT_SALES
		union
		select sum(total_bill) amounts from REPORTS.DW_POSTPAID_AMOUNTS_WEEKLY)
	SQL
	result = Report.connection.exec_query(query)
  end










end 