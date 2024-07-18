class Confirmation < PrepaidMpesa
  self.table_name = "IPMP_MPESA.CONFIRMATION_REQUEST"
  self.primary_key = "SEQNUM"
  attribute :create_date, :datetime

  scope :created_today, -> { where(create_date: Time.current.beginning_of_day..Time.current.end_of_day) }
  scope :created_one_week_ago, -> { where(create_date: 1.week.ago.beginning_of_day..1.week.ago.end_of_day) }
  scope :having_created_at_between, ->(start_date, end_date) { where(create_date: start_date.beginning_of_day..end_date.end_of_day) }

  include AASM

  enum status: {
    batch: 0,
    pending: 1,
    successfull: 2,
    pending_top_up: 6,
    completed_top_up: 17,
    invalid_meter: 12,
    meter_blocked: 98,
    invalid_amount: 96,
    missing_values: 95,
    unknown_meter: 97,
    blocked_for_reversal: 15,
    reversed_by_safaricom: 11,
    evg_timeout: 80,
    itron_busy: 99
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :batch
    state :successfull
    state :pending_top_up
    state :completed_top_up
    state :invalid_meter
    state :meter_blocked
    state :invalid_amount
    state :unknown_meter
    state :blocked_for_reversal
    state :reversed_by_safaricom
    state :evg_timeout
    state :itron_busy

    event :resend_sms do
      transitions from: :successfull, to: :batch, guard: :message_id_null?
    end

    event :sms_pending do
      transitions from: :pending, to: :successfull, guard: :token_generated?
    end

    event :request_top_up do
      transitions from: :pending, to: :pending_top_up, guard: :meter_has_debt?
    end

    event :revend_top_up do
      transitions from: :completed_top_up, to: :batch, guard: :debt_has_been_cleared?
    end

    event :revend_unknown do
      transitions from: :unknown_meter, to: :batch, before: Proc.new { |*args| change_billrefnumber(*args) }
    end

    event :revend_blocked do
      transitions from: :meter_blocked, to: :batch, before: Proc.new { |*args| change_billrefnumber(*args) }
    end

    event :revend_evg_timeout do
      transitions from: :evg_timeout, to: :batch, guard: :token_was_not_generated?
    end

    event :block_for_reversal do
      transitions from: :blocked_for_reversal, to: :reversed_by_safaricom
    end
  end

  def message_id_null?
    messageid.nil?
  end

  def meter_has_debt?
    # Implement logic here
  end

  def token_generated?
    # Implement logic here
  end

  def change_billrefnumber(number)
    # Implement logic here
  end

  def token_was_not_generated?
    # Implement logic here
  end

  def self.prepaid_validation_success
    query = <<-SQL
      SELECT COUNT(*) AS Transactions
      FROM IPMP_MPESA.CONFIRMATION_REQUEST
      WHERE TRANSTYPE = 'Payment Validation' AND messages = 'Success' AND TRUNC(create_date) = TRUNC(SYSDATE)
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
    result.first['Transactions']
  end

  def self.prepaid_validation_errors
    query = <<-SQL
      SELECT COUNT(*) AS Transactions
      FROM IPMP_MPESA.CONFIRMATION_REQUEST
      WHERE TRANSTYPE = 'Payment Validation' AND messages <> 'Success' AND TRUNC(create_date) = TRUNC(SYSDATE)
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
    result.first['Transactions']
  end

  def self.prepaid_confirmation_success
    query = <<-SQL
      SELECT COUNT(*) AS Transactions
      FROM IPMP_MPESA.CONFIRMATION_REQUEST
      WHERE TRANSTYPE = 'Payment Confirmation' AND messages = 'Success' AND TRUNC(create_date) = TRUNC(SYSDATE)
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
    result.first['Transactions']
  end

  def self.postpaid_confirmation_success
    query = <<-SQL
      SELECT COUNT(*) AS Transactions
      FROM IPMP_MPESA.CONFIRMATION_REQUEST
      WHERE TRANSTYPE = 'Payment Confirmation' AND messages = 'Success' AND TRUNC(create_date) = TRUNC(SYSDATE)
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
    result.first['Transactions']
  end

  def self.group_by_hour
    query = <<-SQL
      SELECT TRUNC(create_date, 'HH24') AS Hour, COUNT(*) AS Requests
      FROM IPMP_MPESA.CONFIRMATION_REQUEST
      WHERE TRUNC(create_date) = TRUNC(SYSDATE)
      GROUP BY TRUNC(create_date, 'HH24')
      ORDER BY TRUNC(create_date, 'HH24') ASC
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
  end

  def self.return_confirmation
    query = <<-SQL
      SELECT INITCAP(DESCRIPTION) AS DESCRIPTION, SUM(TRANS_COUNT) AS TRANSACTION_COUNT
      FROM (
        SELECT CR.STATUS,
          CASE
            WHEN CR.STATUS = 0 THEN 'NEW TRANSACTION PENDING PROCESSING'
            ELSE CRT.DESCRIPTION
          END AS DESCRIPTION,
          COUNT(CR.TRANSID) AS TRANS_COUNT
        FROM IPMP_MPESA.CONFIRMATION_REQUEST CR
        LEFT JOIN MPESA.CONFIRMATION_REQUEST_TYPE CRT ON CRT.TRN_ID = CR.STATUS
        WHERE CR.STATUS <> 2 AND TRUNC(CR.create_date) = TRUNC(SYSDATE)
        GROUP BY CR.STATUS, CRT.DESCRIPTION
      )
      GROUP BY DESCRIPTION
    SQL
    result = PrepaidMpesa.connection.exec_query(query)
  end

  def self.find_token(search)
    columns = %w[mobilenumber transid billrefnumber]
    @confirmations = Confirmation.where(
      columns.map { |c| "#{c} LIKE :search" }.join(' OR '),
      search: "%#{sanitize_sql_like(search)}%"
    )
  end

  def self.hour_minute
    create_date.strftime('%H:%M')
  end

  def to_param
    seqnum.parameterize
  end
end
