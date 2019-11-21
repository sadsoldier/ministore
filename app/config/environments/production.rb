
Rails.application.configure do

    config.active_storage.service = :local

    config.exceptions_app = self.routes

    config.consider_all_requests_local = false

    config.action_controller.perform_caching = true
    config.action_controller.default_protect_from_forgery = false

    config.session_store :cookie_store, key: 'rapp'

    config.cache_classes = true
    config.eager_load = true
    config.require_master_key = true

    config.public_file_server.enabled = true

    #config.force_ssl = true
    config.cache_store = :memory_store, { size: 16.megabytes }
    config.i18n.fallbacks = true

    config.active_support.deprecation = :notify

    config.log_level = :debug
    config.log_tags = [ :request_id ]

    #class CustomFormatter < ActiveSupport::Logger::SimpleFormatter
    #    def call(severity, time, progname, msg)
    #        timestamp = time.strftime("%Y-%m-%d %H:%M:%S.%L %Z")
    #        "#{timestamp} #{severity} #{progname} #{msg}\n"
    #    end
    #end

    #logger = ActiveSupport::Logger.new("@app_logdir@/#{Rails.env}.log")
    #logger.formatter = CustomFormatter.new

    #config.logger = ActiveSupport::TaggedLogging.new(logger)

    config.active_record.dump_schema_after_migration = false
    config.active_record.verbose_query_logs = false


    config.assets.js_compressor = :uglifier
    config.assets.css_compressor = :sass

    #config.assets.cache_limit = 50.megabytes

    #config.assets.configure do |env|
    #    env.cache = Sprockets::Cache::FileStore.new(
    #        File.join('@app_cachedir@/assets'),
    #        config.assets.cache_limit,
    #        env.logger
    #    )
    #end

end
