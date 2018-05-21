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
Rails.application.config.assets.precompile += %w( dashboard02-custom.js jquery.peity.min.js plugins.js appUi-custom.js  select2.min.js jquery.datetimepicker.full.min.js datatables-custom.js jquery.dataTables.min.js dataTables.bootstrap4.min.js dataTables.responsive.min.js responsive.bootstrap4.min.js dropzone.js)
