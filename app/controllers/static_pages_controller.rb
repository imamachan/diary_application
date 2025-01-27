class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: %i[top]

    def top
      @hide_header_footer = true
    end
end
