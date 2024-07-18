class Contact < ApplicationRecord
  #acts_as_tenant(:organization)
  has_many :audiences, through: :subscribers

  belongs_to :organization, optional: true
  

  has_many :subscribers, :dependent => :destroy
  has_many :teams, -> { distinct } , through: :subscribers

  #validates :number, uniqueness: { scope: :team_id}
  #validates_uniqueness_of :number
  validates :number, presence: true, format: { with: /\d{9}/i, message: "is of invalid format"}

	  def send_message(message)
	      request_body = {
	              "messages": message,  ##try html safe to fix LANG&apos;O
	              "mobile": ["+254#{number}"],
	              "sms_ID": id 
	              }
	      headers = {
	        "Content-Type" =>  "application/json"
	      }
	      response = HTTParty.post("http://172.16.4.53:8080/api/send-sms",:headers => headers ,body: request_body.to_json, timeout: 10 )
	end



def self.import(file)
 #  upload = Roo::Spreadsheet.open(file)
 #  upload.default_sheet = upload.sheets[1]
 #  #contacts = upload.sheets[1]

 # #puts  contacts.row(1)
 # # puts  contacts.column(1)

 #  puts upload.sheets[1]
	#   # Iterate through each sheet
	#   #["SMS users", "Contacts", "Groups"]
	# u.each_with_pagename do |name, sheet|
	#   puts sheet.row(1)
	# end


  # header = spreadsheet.row(1)
  # (2..spreadsheet.last_row).each do |i|
  #   row = Hash[[header, spreadsheet.row(i)].transpose]
  #   contact = find_by_id(row["id"]) || new
  #   contact.attributes = row.to_hash.slice(*accessible_attributes)
  #   contact.save!
  # end

end

# def self.open_spreadsheet(file)
#   case File.extname(file.original_filename)
#   when ".csv" then Csv.new(file.path, nil, :ignore)
#   when ".xls" then Excel.new(file.path, nil, :ignore)
#   when ".xlsx" then Excelx.new(file.path, nil, :ignore)
#   else raise "Unknown file type: #{file.original_filename}"
#   end
# end



end


