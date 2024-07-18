KPLCOVS_DB_DR = YAML.load_file(File.join(Rails.root, "config", "kplc_ovs_dr.yml"))[Rails.env.to_s]

# config = YAML::load(ERB.new(File.read(Rails.root.join(“config”,“kplc_ovs.yml”))).result)
# DB_SECOND = config[Rails.env]