
class AdminConstraint

    def current_user(request)
        User.find_by_id(request.session[:user_id])
    end

    def matches?(request)
        user = current_user(request)
        if user 
            user.is_admin
        else
            false
        end
    end
end

class UserConstraint

    def current_user(request)
        User.find_by_id(request.session[:user_id])
    end

    def matches?(request)
        user = current_user(request)
        user != nil
    end
end


Rails.application.routes.draw do

    get 'api/documents', to: 'document#api_index', as: 'api_document_index'
    post 'api/document/upload', to: 'document#api_upload', as: 'api_document_upload'
    match 'api/document/download', via: [:post, :get], to: 'document#api_download', as: 'api_document_download'
    match 'api/document/search', via: [:post, :get], to: 'document#api_search', as: 'api_document_search'

    localized do
        get 'login', to: 'session#new', as: 'login'

        get 'logout', to: 'session#destroy', as: 'logout'
        post 'auth', to: 'session#create', as: 'auth'

        constraints UserConstraint.new do
            get 'documents', to: 'document#index', as: 'document_index'
            #get 'document/download', to: 'document#download', as: 'document_download'
            post 'document/upload', to: 'document#upload', as: 'document_upload'
        end

        constraints AdminConstraint.new do
            get 'users', to: 'user#index', as: 'user_index'
            post 'user/create', to: 'user#create', as: 'user_create'
            post 'user/drop', to: 'user#drop', as: 'user_drop'
            post 'user/update', to: 'user#update', as: 'user_update'
        end

        match "/404", to: "error#not_found", via: :all
        match "/402", to: "error#not_found", via: :all
        match "/422", to: "error#unacceptable", via: :all
        match "/500", to: "error#internal_error", via: :all
        match "/503", to: "error#internal_error", via: :all

        match '*all', to: 'application#index', via: :all, constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
    end

    root to: 'home#index'

end
