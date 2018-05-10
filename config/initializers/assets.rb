# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( assets/javascripts/dashboard02-custom.js assets/javascripts/jquery.peity.min.js assets/javascripts/plugins.js assets/javascripts/appUi-custom.js  assets/javascripts/select2.min.js assets/javascripts/jquery.datetimepicker.full.min.js assets/javascripts/datatables-custom.js assets/javascripts/jquery.dataTables.min.js assets/javascripts/dataTables.bootstrap4.min.js assets/javascripts/dataTables.responsive.min.js assets/javascripts/responsive.bootstrap4.min.js assets/javascripts/dropzone.js)
