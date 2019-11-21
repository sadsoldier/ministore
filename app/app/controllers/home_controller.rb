
class HomeController < ApplicationController

    #before_filter :set_locale

    def index
        if session[:user_id]
            redirect_to document_index_path
        else
            set_locale
            redirect_to login_path
        end
    end

    def set_locale
        I18n.locale = extract_locale_from_headers
    end

    private

    def extract_locale_from_headers
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first.presence || 'en'
    end

end
