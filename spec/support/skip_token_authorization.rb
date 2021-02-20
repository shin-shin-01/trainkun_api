# frozen_string_literal: true

module SkipTokenAuthorization
  def skip_token_authorization
    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(AuthorizationService).to receive(:verify_token).and_return(true)
    # rubocop:enable RSpec/AnyInstance
  end
end
