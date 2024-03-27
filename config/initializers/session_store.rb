# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: '_fable_backend', domain: 'fablesearch.com', same_site: :strict,
                                                      secure: true, expire_after: 30.minutes
