class Campaign < ApplicationRecord
  #acts_as_tenant(:organization)
  belongs_to :team 
  belongs_to :organization

  validates_presence_of :name, :type
  belongs_to :audience
  belongs_to :user

  serialize :broadcast_contacts, Array
  serialize :failed_contacts, Array

  before_save :update_broadcast
  after_commit :broadcast_to_audience, on: :create

  validates :message, presence: true, allow_blank: false

  scope :bulk, -> { where(type: 'Bulk') } 
  scope :api, -> { where(type: 'Api') } 
  scope :scheduled, -> { where(type: 'Scheduled') }
  scope :survey, -> { where(type: 'Survey') } 

  # include PublicActivity::Model
  # tracked
  # tracked owner: Proc.new{ |controller, model| controller.current_user }


  def self.types
    %w(Bulk Api Schedule Survey)
  end


  private 

  def update_broadcast
    self.broadcast_contacts = audience.contacts.pluck(:id)
  end

   def broadcast_to_audience
     CampaignWorker.perform_async(self.id) #unless self.content     ##This method makes sure it is not sent to an infinite loop as after commit will be called after every save or update,only for sidekiq
   end



end


