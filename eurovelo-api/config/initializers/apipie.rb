Apipie.configure do |config|
  config.app_name                = "EuroveloApi"
  config.api_base_url            = ""
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "**","*.rb")
  config.translate               = false
end
