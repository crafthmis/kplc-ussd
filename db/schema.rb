# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_16_170417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accountments", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_accountments_on_account_id"
    t.index ["customer_id"], name: "index_accountments_on_customer_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "number"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_accounts_on_number"
  end

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.bigint "trackable_id"
    t.string "owner_type"
    t.bigint "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties_jsonb_path_ops", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "audiences", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.bigint "team_id"
    t.index ["organization_id"], name: "index_audiences_on_organization_id"
    t.index ["team_id"], name: "index_audiences_on_team_id"
  end

  create_table "billables", force: :cascade do |t|
    t.string "request_id"
    t.string "request_timestamp"
    t.string "response_id"
    t.string "channel"
    t.string "offer_code"
    t.bigint "customer_id"
    t.string "content"
    t.bigint "meter_id"
    t.bigint "account_id"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status_code"
    t.string "description"
    t.string "link_id"
    t.string "error_code"
    t.index ["account_id"], name: "index_billables_on_account_id"
    t.index ["customer_id"], name: "index_billables_on_customer_id"
    t.index ["meter_id"], name: "index_billables_on_meter_id"
  end

  create_table "blazer_audits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "query_id"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at"
    t.index ["query_id"], name: "index_blazer_audits_on_query_id"
    t.index ["user_id"], name: "index_blazer_audits_on_user_id"
  end

  create_table "blazer_checks", force: :cascade do |t|
    t.bigint "creator_id"
    t.bigint "query_id"
    t.string "state"
    t.string "schedule"
    t.text "emails"
    t.text "slack_channels"
    t.string "check_type"
    t.text "message"
    t.datetime "last_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_checks_on_creator_id"
    t.index ["query_id"], name: "index_blazer_checks_on_query_id"
  end

  create_table "blazer_dashboard_queries", force: :cascade do |t|
    t.bigint "dashboard_id"
    t.bigint "query_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dashboard_id"], name: "index_blazer_dashboard_queries_on_dashboard_id"
    t.index ["query_id"], name: "index_blazer_dashboard_queries_on_query_id"
  end

  create_table "blazer_dashboards", force: :cascade do |t|
    t.bigint "creator_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_dashboards_on_creator_id"
  end

  create_table "blazer_queries", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "name"
    t.text "description"
    t.text "statement"
    t.string "data_source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_blazer_queries_on_creator_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.bigint "audience_id"
    t.text "message"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "broadcast_contacts"
    t.string "failed_contacts"
    t.string "status"
    t.bigint "organization_id"
    t.bigint "team_id"
    t.index ["audience_id"], name: "index_campaigns_on_audience_id"
    t.index ["organization_id"], name: "index_campaigns_on_organization_id"
    t.index ["team_id"], name: "index_campaigns_on_team_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "complaints", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "info"
    t.string "complaintable_type"
    t.bigint "complaintable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved", default: false, null: false
    t.string "state"
    t.index ["complaintable_type", "complaintable_id"], name: "index_complaints_on_complaintable_type_and_complaintable_id"
    t.index ["customer_id"], name: "index_complaints_on_customer_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.string "first_name"
    t.string "last_name"
    t.index ["organization_id"], name: "index_contacts_on_organization_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_notification", default: false, null: false
    t.boolean "sms_notification", default: false, null: false
    t.string "email"
    t.index ["number"], name: "index_customers_on_number"
  end

  create_table "demands", force: :cascade do |t|
    t.string "request_id"
    t.string "request_timestamp"
    t.string "channel"
    t.string "offer_code"
    t.bigint "customer_id"
    t.string "link_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "response"
    t.integer "error_code"
    t.boolean "insmm", default: false, null: false
    t.integer "insmm_id"
    t.index ["customer_id"], name: "index_demands_on_customer_id"
    t.index ["link_id"], name: "index_demands_on_link_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.integer "staff_number"
    t.string "job_category"
    t.string "region"
    t.string "station"
    t.string "job_title"
    t.string "division"
    t.string "section"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_number"], name: "index_employees_on_staff_number", unique: true
  end

  create_table "equities", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "amount"
    t.string "status"
    t.string "equitable_type"
    t.bigint "equitable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_equities_on_customer_id"
    t.index ["equitable_type", "equitable_id"], name: "index_equities_on_equitable_type_and_equitable_id"
  end

  create_table "incidences", force: :cascade do |t|
    t.string "kind"
    t.string "explanation"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "full_address"
    t.string "state"
    t.string "county"
    t.index ["customer_id"], name: "index_incidences_on_customer_id"
    t.index ["latitude"], name: "index_incidences_on_latitude"
    t.index ["longitude"], name: "index_incidences_on_longitude"
  end

  create_table "interfaces", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.string "code"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.integer "service"
    t.index ["customer_id"], name: "index_messages_on_customer_id"
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id"
    t.index ["service"], name: "index_messages_on_service"
  end

  create_table "meterizations", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "meter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_meterizations_on_customer_id"
    t.index ["meter_id"], name: "index_meterizations_on_meter_id"
  end

  create_table "meters", force: :cascade do |t|
    t.string "number"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_meters_on_number"
  end

  create_table "mpesas", force: :cascade do |t|
    t.string "merchant_request_id"
    t.string "checkout_request_id"
    t.string "customer_message"
    t.string "result_code"
    t.string "result_desc"
    t.string "amount"
    t.string "mpesa_receipt_number"
    t.string "transaction_date"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mpesable_type"
    t.bigint "mpesable_id"
    t.index ["checkout_request_id"], name: "index_mpesas_on_checkout_request_id"
    t.index ["customer_id"], name: "index_mpesas_on_customer_id"
    t.index ["merchant_request_id"], name: "index_mpesas_on_merchant_request_id"
    t.index ["mpesa_receipt_number"], name: "index_mpesas_on_mpesa_receipt_number"
    t.index ["mpesable_type", "mpesable_id"], name: "index_mpesas_on_mpesable_type_and_mpesable_id"
  end

  create_table "organization_interfaces", force: :cascade do |t|
    t.bigint "interface_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interface_id"], name: "index_organization_interfaces_on_interface_id"
    t.index ["organization_id"], name: "index_organization_interfaces_on_organization_id"
  end

  create_table "organization_users", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.integer "owner_id"
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "readings", force: :cascade do |t|
    t.string "number"
    t.bigint "account_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_readings_on_account_id"
    t.index ["customer_id"], name: "index_readings_on_customer_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "text"
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_requests_on_customer_id"
    t.index ["kind"], name: "index_requests_on_kind"
    t.index ["session_id"], name: "index_requests_on_session_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "settings", force: :cascade do |t|
    t.boolean "ussd_sms"
    t.boolean "prepaid_token"
    t.boolean "postpaid_token"
    t.boolean "find_contractor"
    t.boolean "find_employee"
    t.boolean "short_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_channels", force: :cascade do |t|
    t.string "type"
    t.string "shortcode"
    t.string "alphanumeric"
    t.string "keyword"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_sms_channels_on_organization_id"
  end

  create_table "sms_templates", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.bigint "team_id"
    t.index ["organization_id"], name: "index_sms_templates_on_organization_id"
    t.index ["team_id"], name: "index_sms_templates_on_team_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "audience_id"
    t.bigint "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.index ["audience_id"], name: "index_subscribers_on_audience_id"
    t.index ["contact_id"], name: "index_subscribers_on_contact_id"
    t.index ["organization_id"], name: "index_subscribers_on_organization_id"
  end

  create_table "team_interfaces", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "organization_interface_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_team_interfaces_on_organization_id"
    t.index ["organization_interface_id"], name: "index_team_interfaces_on_organization_interface_id"
    t.index ["team_id"], name: "index_team_interfaces_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.bigint "organization_id"
    t.text "description"
    t.index ["organization_id"], name: "index_teams_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "audiences", "organizations"
  add_foreign_key "audiences", "teams"
  add_foreign_key "billables", "accounts"
  add_foreign_key "billables", "customers"
  add_foreign_key "billables", "meters"
  add_foreign_key "campaigns", "audiences"
  add_foreign_key "campaigns", "organizations"
  add_foreign_key "campaigns", "teams"
  add_foreign_key "campaigns", "users"
  add_foreign_key "contacts", "organizations"
  add_foreign_key "demands", "customers"
  add_foreign_key "equities", "customers"
  add_foreign_key "incidences", "customers"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "customers"
  add_foreign_key "mpesas", "customers"
  add_foreign_key "organization_interfaces", "interfaces"
  add_foreign_key "organization_interfaces", "organizations"
  add_foreign_key "organization_users", "organizations"
  add_foreign_key "organization_users", "users"
  add_foreign_key "projects", "teams"
  add_foreign_key "readings", "accounts"
  add_foreign_key "readings", "customers"
  add_foreign_key "requests", "customers"
  add_foreign_key "sms_channels", "organizations"
  add_foreign_key "sms_templates", "organizations"
  add_foreign_key "sms_templates", "teams"
  add_foreign_key "subscribers", "audiences"
  add_foreign_key "subscribers", "contacts"
  add_foreign_key "subscribers", "organizations"
  add_foreign_key "team_interfaces", "organization_interfaces"
  add_foreign_key "team_interfaces", "organizations"
  add_foreign_key "team_interfaces", "teams"
  add_foreign_key "teams", "organizations"
end
