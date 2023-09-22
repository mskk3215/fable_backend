# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: '_fable_backend', domain: '.fable-230918-24b3a9e93ee3.herokuapp.com', same_site: :none, secure: true
