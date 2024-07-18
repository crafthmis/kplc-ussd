class Cost < Report
  self.table_name = "REPORTS.DW_COSTS"
  #self.primary_key = "trn_id"

  


  def self.sales 
	query = <<-SQL 
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
	SQL
	result = Report.connection.exec_query(query)
  end

  def self.energy_purchase_cost
	  query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
	  SQL
	result = Report.connection.exec_query(query)
  end

  def self.other_costs
	query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
	SQL
	result = Report.connection.exec_query(query)
  end

  def self.profit 
  	query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
  	SQL
  	result = Report.connection.exec_query(query)
  end

  def self.sales_vs_cost_trend
    query = <<-SQL
		select to_char(to_date(table1.period,'yyyymm'),'Mon')||'-'||substr(table1.period,1,4) PP,table1.period,
		round(sum(table1.amounts)/1000000000,2) " Sales",round(sum(table3.energy_purchase_cost)/1000000000,2) "Energy purchase costs", 
		round(sum(table3.other_costs)/1000000000,2) "Other Costs",
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/1000000000,2) profit,
		round((sum(table1.amounts) - (sum(table3.energy_purchase_cost)+ sum(table3.other_costs)))/sum(table1.amounts)*100,2) profit_margin
		from 
		(select TO_CHAR(MONTH_YEAR,'YYYYMM') period,sum(amount) amounts from reports.DW_SALES_FROM_SAP
		group by MONTH_YEAR) table1

		join
		(select to_char(month,'yyyymm') period, sum(other_costs) other_costs,--sum(staff_cost) staff_cost,sum(finance_cost) finance_cost,
		sum(power_purchase_cost) energy_purchase_cost 
		from REPORTS.DW_costs where to_char(month,'yyyymm') <= '202006'
		group by month) table3 on table1.period=table3.period
		group by table1.period
		order by table1.period
    SQL
    result = Report.connection.exec_query(query)
  end

  def self.energy_kwhrs
  	query = <<-SQL
  	  select source, round(sales,2) sales from REPORTS.DW_ENERGY_SOURCE_ANNUAL
    SQL
    result = Report.connection.exec_query(query)
  end

  def self.collections
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

  def self.new_connections 
   query = <<-SQL
	SELECT to_char(to_date(period,'yyyymm'),'Mon')||'-'||substr(period,1,4) PP,SUM(NEW_CONNECTIONS) NEW_CONNECTIONS 
	FROM reports.DW_NEW_CONNECTIONS_PERIODS
	where period >= '201907' and period <= '202006'
	GROUP BY period
	order by period;
   SQL
   result = Report.connection.exec_query(query)
  end

  def self.caidi 
  	query = <<-SQL
	  select indice,period,valor_indice VALUE,nom_instalacion 
	  from REPORTS.DW_IMS_INDICES
	  where TIPO_INSTALACION=0 and indice='CAIDI' AND
	  FECHA_INICIO >= TO_DATE('01/07/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
	  FECHA_INICIO < TO_DATE('01/07/2020 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
	  order by FECHA_INICIO
    SQL
    result = Report.connection.exec_query(query)

  end

  def self.saidi 
  	query = <<-SQL
	  	select indice,period,valor_indice VALUE,nom_instalacion 
	    from REPORTS.DW_IMS_INDICES
	    where TIPO_INSTALACION=0 and indice='SAIDI' AND
	    FECHA_INICIO >= TO_DATE('01/07/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
	    FECHA_INICIO < TO_DATE('01/07/2020 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
	    order by FECHA_INICIO 
  	SQL
  	result = Report.connection.exec_query(query)
  end

  def self.saifi 
  	query = <<-SQL 
	  	select indice,period,valor_indice VALUE,nom_instalacion 
	    from REPORTS.DW_IMS_INDICES
	    where TIPO_INSTALACION=0 and indice='SAIFI' AND
	    FECHA_INICIO >= TO_DATE('01/07/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
	    FECHA_INICIO < TO_DATE('01/07/2020 00:00:00', 'DD/MM/YYYY HH24:MI:SS')
	    order by FECHA_INICIO ;
  	SQL
  	result = Report.connection.exec_query(query)
  end






end 