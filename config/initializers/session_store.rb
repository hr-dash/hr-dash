# Be sure to restart your server when you modify this file.

# would set the session cookie to expire automatically 1 day after creation.
Rails.application.config.session_store :cookie_store, key: '_dash_session', expire_after: 1.day
