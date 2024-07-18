class Contractor < Incms
  self.table_name = "CONTRACTORS_DETAIL"

    def self.find_contractor(id)
    begin
    #cursor = Incms.connection.execute("SELECT DISTINCT ID_NUMBER  as IDNO,STAFF_NAME AS NAME FROM CONTRACTORS_DETAIL WHERE CONTRACTORS_STATUS=1 AND ID_NUMBER= #{id}")
    contractor = self.where(contractors_status: 1).where(id_number: id).first
    #row = cursor.fetch()
    response =    if contractor
                    "ID NO.#{id},#{contractor.staff_name} is a Kenya Power Contractor."
                  else
                    #"CON ID NO.#{id} is a fraudster, report immediately on the Anti-Fraud Hotline Number: 0718-999-000"
                    "We have not found data about the KP contractor."
                  end
    rescue => error
      ExceptionNotifier.notify_exception(error)
      response = "The request could not be completed, try again later."
    end

    return response
  end

end