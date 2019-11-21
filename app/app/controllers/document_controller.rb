class DocumentController < ApplicationController

    before_action :authenticate

    def index
        @pagy, @documents = pagy(Document.all.order(name: :desc))
        render 'index'
    end

    def upload
        document = Document.new
        document.app_id = params[:app_id]
        document.document_id = params[:document_id]
        document.save
        redirect_to document_index_path
    end

    def api_index
        render json: Document.all
    end

    def api_upload
        document = Document.new
        document.app_id = params[:app_id]
        document.document_id = params[:document_id]
        document.file = params[:file]
        document.save

        if document.valid?
            render json: { result: { document: document, blob: document.file.blob, url: url_for(document.file) } }
        else
            reason = document.errors.full_messages.join(';').downcase
            render json: { result: { document: nil,  reason: "#{reason}" } }
        end

        #render json: { result: ActiveStorage::Blob.service.send(:path_for, document.file.key) }
    end

    def api_search
        document = Document.find_by(app_id: params[:app_id], document_id: params[:document_id])
        if document 
            render json: { result: { document: document, blob: document.file.blob, url: url_for(document.file) } }
        else
            render json: { result: { document: nil, reason: "not found" } }
        end
    end

    def api_download
        head 404, content_type: 'text/plain'
            document = Document.find_by(app_id: params[:app_id], document_id: params[:document_id])
            if document
                redirect_to url_for(document.file)
            else
                head 404, content_type: 'text/plain'
            end
    end

    private

    def authenticate
        if !session[:user_id]
            authenticate_or_request_with_http_basic do |username, password|
                User.find_by(username: username).try(:authenticate, password) 
            end
        end
    end

end
