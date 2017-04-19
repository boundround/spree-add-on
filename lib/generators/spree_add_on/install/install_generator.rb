module SpreeAddOn
  module Generators
    class InstallGenerator < Rails::Generators::Base

      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        if File.exists? 'app/assets/javascripts/admin/all.js'
          append_file 'app/assets/javascripts/admin/all.js', "//= require admin/spree_add_on\n"
        end
        if File.exists? 'app/assets/javascripts/store/all.js'
          append_file 'app/assets/javascripts/store/all.js', "//= require store/spree_add_on\n"
        end
      end

      def add_stylesheets
        if File.exists? 'app/assets/stylesheets/admin/all.css'
          inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_add_on\n", before: /\*\//, verbose: true
        end
        if File.exists? 'app/assets/stylesheets/admin/all.css'
          inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require store/spree_add_on\n", before: /\*\//, verbose: true
        end
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_add_on'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
