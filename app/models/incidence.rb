class Incidence < ApplicationRecord
   paginates_per 50

  include UssdApis
  include Scopeable



  include AASM

  aasm column: :state do
    state :open , initial: true
    state :closed

    event :resolve do
      transitions from: :open, to: :closed
    end

    event :unresolve do
      transitions from: :closed, to: :open
    end

  end


  belongs_to :customer

  geocoded_by :full_address
  after_validation :geocode

  #after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.full_address_changed? }
  #before_save :set_county

  #reverse_geocoded_by :latitude, :longitude, address: :address
  enum kind: { safety: 0 }


  POWEROUTAGE = ["Equipment or Transformer failure","Trees or limbs","Bird or animal","Motor vehicle","Unknown or Other"]


 reverse_geocoded_by :latitude, :longitude do |obj,results|
  if geo = results.first
    obj.county    = geo.state
    #obj.zipcode = geo.postal_code
    #obj.country = geo.country_code
  end
end
before_save :reverse_geocode
before_save :set_enum

 # def address
 #   "#{address} Kenya"
 # end

  def self.report_incidence(customer,text,ussd_vendor,sdp)
  implement_back_button(text)
    if text == "4"
      response = "CON Select incidence type\n1:Power Outage\n2:Safety Incidence\n3:Staff Misconduct\n4:Illegal Connection"
    end

    if text =~ /\A4\*2\Z/
      response = "CON Briefly describe the safety incidence e.g Fallen cables"
    end

    if text =~ /\A4\*2\*([^*]+)\Z/
      response = "CON Input the incidence location e.g Moi avenue Nairobi"
    end

    if text =~ /\A4\*2\*([^*]+)\*([^*]+)\Z/
      explanation = $1
      address = $2
      pref_si = "SI: "
      #response = get_locations(customer,explanation,address)
      location = [address,'KENYA'].compact.join(', ')

      incidence = customer.incidences.create(kind: 0,explanation: pref_si + explanation,full_address: location)
      response = "CON Safety incidence at #{address.titleize} has been created. Reference: ##{incidence.id}"

    end

   if text =~ /\A4\*4\Z/
      response = "CON Briefly describe the illegal connection e.g Direct Connection"
    end

    if text =~ /\A4\*4\*([^*]+)\Z/
      response = "CON Input the illegal connection location e.g Kolobot Road Stima Plaza"
    end

    if text =~ /\A4\*4\*([^*]+)\*([^*]+)\Z/
      explanation = $1
      address = $2
      pref_ic = "IC: "
      #response = get_locations(customer,explanation,address)
      location = [address,'KENYA'].compact.join(', ')

      incidence = customer.incidences.create(kind: 0,explanation: pref_ic + explanation,full_address: location)
      response = "CON Illegal Connection Case at #{address.titleize} has been created. Reference: ##{incidence.id}"

    end




  #   if text =~ /\A4\*2\*([^*]+)\*([^*]+)\*(\d+)\Z/
  #     explanation = $1
  #     address = $2
  #     exact_address = $3
  #     response = "CON "

  #    location = [address,'KENYA'].compact.join(', ')
	 # results ||= find_location(location)

	 # counties ||= results.map(&:state).uniq.sort

	 #   if counties.size >  1
	 #   	 county = counties[exact_address.to_i-1]
	 #     new_location = [address,county,'KENYA'].compact.join(', ')

	 #   	 new_results ||= find_location(new_location)
	 #   	 new_address = new_results.map(&:address).sort


  #      	    response += "Select nearest location\n"
  #      		new_address.each_with_index do |location,index|
  #      			response += "#{index+1}:#{location}\n"
  #      		end
  #      	else
  #      	  exact_location = results.map(&:address).sort[exact_address.to_i-1]
  #      	  incidence = customer.incidences.create(kind: 0,explanation: explanation,full_address: exact_location )
  #     	  response += "Safety incidence at #{exact_location} has been created. Reference: ##{incidence.id}"
  #      	end
  #   end

  #   if text =~ /\A4\*2\*([^*]+)\*([^*]+)\*(\d+)\*(\d+)\Z/
  #     explanation = $1
  #     address = $2
  #     exact_address = $3
  #     exact_location = $4

  #    location = [address,'KENYA'].compact.join(', ')
	 # results = find_location(location)
	 # counties = results.map(&:state).uniq.sort

	 # exact_county = counties[exact_address.to_i-1]

	 # new_location = [address,exact_county,'KENYA'].compact.join(', ')
	 # new_locations ||= find_location(new_location)

	 # final_location = results.map(&:address).sort[exact_location.to_i-1]

	 # incidence = customer.incidences.create(kind: 0,explanation: explanation,full_address: final_location )
  #    response = "CON Safety incidence at #{final_location} has been created. Reference: ##{incidence.id}"
  #   end














    if text =~ /\A4\*1\Z/
     response = "CON Select account type\n1:Prepaid\n2:Postpaid"
    end

    if text =~ /\A4\*1\*1.*\Z/
      next_prompt = lambda { |account,customer,text,kind,option| log_complaint(account,customer,text,kind,option)}
      last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_method(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}
      response = initialize_profile(customer,text,'4\*1\*1','meter',next_prompt,last_prompt,ussd_vendor,sdp)
    end

    if text =~ /\A4\*1\*2.*\Z/
     next_prompt = lambda { |account,customer,text,kind,option| log_complaint(account,customer,text,kind,option)}
     last_prompt = lambda { |meter,second_param,customer,text,kind,option,ussd_vendor,sdp| last_method(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)}
     response = initialize_profile(customer,text,'4\*1\*2','account',next_prompt,last_prompt,ussd_vendor,sdp)
    end


    if text =~ /\A4\*3.*\Z/
     response = Complaint.staff_misconduct(customer,text,ussd_vendor)
    end

  return add_home_buttons(text,response)
end

def self.get_locations(customer,explanation,address)
	 location = [address,'KENYA'].compact.join(', ')
	 results ||= Geocoder.search(location)
      response = "CON "
      #puts results
       unless results.empty?
       	counties = results.map(&:state).uniq.sort

       	if counties.size >  1
       		response += "Select county\n"
       		counties.each_with_index do |county,index|
       			response += "#{index+1}:#{county}\n"
       		end
       	else
       	  new_address = results.map(&:address).sort
       	  response += "Select nearest location\n"
       	  new_address.each_with_index do |location,index|
       	  	response += "#{index+1}:#{location}\n"
       	  end
       	end

      else
      	incidence = customer.incidences.create(kind: 0,explanation: explanation,full_address: address)
      	response += "Location not found. Safety incidence at #{address.titleize} has been created. Reference: ##{incidence.id}"
      end
     return response
end



private

 def self.find_location(address)
   results = Geocoder.search(address)
 end



 def set_enum
  self.kind = 0
 end

 def self.log_complaint(account,customer,text,kind,option)
    response = "CON What caused the outage?\n"
    POWEROUTAGE.each_with_index do |key,value|
      response += "#{value+1}:#{key}\n"
    end
    return response
  end

  def self.last_method(meter,second_param,customer,text,kind,option,ussd_vendor,sdp)
    begin   ##number is within the method where it is called.
     cause = POWEROUTAGE[second_param.to_i - 1]
     text = HTTParty.get("http://prsc01-ingriddb-scan.kplc.local:8090/KEIOPEN/iopen/lodge/#{meter.number}/SMS/#{customer.number}/1/1/#{cause.delete(' ')}/", :verify => false )
     response = "CON #{text}"
    rescue StandardError
       ExceptionNotifier.notify_exception(StandardError)
      response = "CON The transaction took too long to complete."
     end
    return response
  end

end
