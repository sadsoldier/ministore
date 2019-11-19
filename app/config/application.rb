
require_relative 'boot'

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module Rapp5
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.available_locales = [:en, :ru]
    config.i18n.default_locale = :en

    file_name = "/home/ziggi/rapp4bw/app/config/config.yml"

    if File.file?(file_name)
        configx = YAML.load(ERB.new(File.read(file_name)).result)
        config.records_dir = configx["records_dir"]
    else
        config.records_dir = "/data/asterisk"
    end

    config.assets.digest = true
    config.assets.css_compressor = :sass
    config.assets.js_compressor = :uglifier
    config.assets.gzip = true

    config.paths['config/database'] = ["/home/ziggi/rapp4bw/app/config/database.yml"]

    class CustomFormatter < ActiveSupport::Logger::SimpleFormatter
        def call(severity, time, progname, msg)
            timestamp = time.strftime("%Y-%m-%d %H:%M:%S.%L %Z")
            "#{timestamp} #{severity} #{progname} #{msg}\n"
        end
    end

    logger = ActiveSupport::Logger.new("/home/ziggi/rapp4bw/app/log/#{Rails.env}.log")
    logger.formatter = CustomFormatter.new
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    config.assets.cache_limit = 50.megabytes
    config.assets.configure do |env|
        env.cache = Sprockets::Cache::FileStore.new(
            File.join('/home/ziggi/rapp4bw/app/tmp/cache/assets'),
            config.assets.cache_limit,
            env.logger
        )
    end

  end

end

RouteTranslator.config do |config|
    config.force_locale = true
    config.generate_unlocalized_routes = true
    config.generate_unnamed_unlocalized_routes = true
#    config.locale_param_key = :locale
end

