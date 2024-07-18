class ImsIndices < Report
  self.table_name = "REPORTS.DW_IMS_INDICES"
  #self.primary_key = "trn_id"

  


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
		order by FECHA_INICIO
	SQL
	result = Report.connection.exec_query(query)
  end





end 
