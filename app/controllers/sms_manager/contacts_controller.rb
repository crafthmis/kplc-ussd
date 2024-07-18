class SmsManager::ContactsController < SmsManagerController
  before_action :set_team 
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET /sms_manager/contacts
  # GET /sms_manager/contacts.json
  def index
    @contacts = current_organization.contacts.all
  end

  # GET /sms_manager/contacts/1
  # GET /sms_manager/contacts/1.json
  def show
  end

  # GET /sms_manager/contacts/new
  def new
    @contact = current_organization.contacts.new
  end

  # GET /sms_manager/contacts/1/edit
  def edit
  end


  def import 
    #Contact.import(params[:file])
      upload = Roo::Spreadsheet.open(params[:file])

    puts headers = upload.sheet(1).row(1)


  # No.  Name Contact number  Group name

    current_sheet = upload.sheet(1)
    header = current_sheet.row(1)
    (2..current_sheet.last_row).each do |i|
      row = Hash[[header, current_sheet.row(i)].transpose]
      #puts row 
      #contact = find_by_id(row["number"]) || new
      last_name, first_name = row["Name "].reverse.split(/\s+/, 2).collect(&:reverse)
      team = Team.where(organization_id: current_organization.id ,name: row["Group name"],owner: current_user).first_or_initialize
      team.save! 
      audience = Audience.where(organization_id: current_organization.id ,name: row["Group name"],team: team).first_or_initialize
      audience.save!
      contact = Contact.where(organization_id: current_organization.id ,number: row["Contact number"]).first_or_initialize
      contact.first_name = first_name
      contact.last_name = last_name
      contact.save!

      subscri = Subscriber.where(organization_id: current_organization.id,contact_id: contact.id, team_id: team.id ,audience_id: audience.id).first_or_initialize
      subscri.save!

      # "Contact(id: integer, number: string, created_at: datetime, updated_at: 
      # datetime, organization_id: integer, first_name: string, last_name: string)"
      
      
    end
    # Iterate through each sheet
    #["SMS users", "Contacts", "Groups"]
  # upload.each_with_pagename do |name, sheet|
  #   puts sheet.row(1)
  # end



        # Iterate through each sheet
        #["SMS users", "Contacts", "Groups"]
      # upload.each_with_pagename do |name, sheet|
      #   puts sheet.row(1)
      # end

    render :new 
    #redirect_to team_sms_manager_audience_path(@contact), notice: "Contacts imported"
  end

  # POST /sms_manager/contacts
  # POST /sms_manager/contacts.json
  def create
    @contact = current_organization.contacts.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to team_sms_manager_contacts_path(current_team), notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_manager/contacts/1
  # PATCH/PUT /sms_manager/contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to team_sms_manager_contacts_path(current_team), notice: 'Contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_manager/contacts/1
  # DELETE /sms_manager/contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to team_sms_manager_contacts_path(current_team), notice: 'Contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
   def set_team
    @team = current_organization.teams.find(params[:team_id])
   end
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = current_organization.contacts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:name, :number)
    end
end
