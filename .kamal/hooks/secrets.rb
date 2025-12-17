require 'dotenv'

KAMAL_ROOT   ||= File.expand_path('../../', __FILE__)
SECRETS_PATH ||= File.join(KAMAL_ROOT, 'secrets')
SECRETS      ||= ::Dotenv.parse(SECRETS_PATH)
