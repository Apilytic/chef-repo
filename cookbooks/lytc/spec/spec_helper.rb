require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
    config.color = true
    config.order = 'random'
    config.filter_run_excluding broken: true
    config.platform = 'debian'
    config.version = '8.0'
    config.log_level = :error
    config.warnings = false
    # config.formatter = 'documentation'
end
