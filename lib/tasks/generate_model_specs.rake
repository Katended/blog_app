namespace :generate do
  desc 'Generate unit test specs for all models'
  task model_specs: :environment do
    models_path = Rails.root.join('app', 'models')

    Dir.glob(models_path.join('**', '*.rb')).each do |model_file|
      model_name = File.basename(model_file, '.rb').camelize
      spec_path = Rails.root.join('app', 'models', "#{model_name.underscore}_spec.rb")

      next if File.exist?(spec_path)

      File.open(spec_path, 'w') do |file|
        file.puts "require 'rails_helper'\n\n"
        file.puts "RSpec.describe #{model_name}, type: :model do"
        file.puts "  pending 'add some examples to (or delete) #{__FILE__}'"
        file.puts 'end'
      end
    end
  end
end
