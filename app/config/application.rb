
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

    config.records_dir = "/data/asterisk"

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

