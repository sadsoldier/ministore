
class Document < ApplicationRecord

    has_one_attached :file

    validates_presence_of :app_id, :document_id
    validates_uniqueness_of :document_id, scope: :app_id

    validate :file_validation

    def file_validation
        if file.attached?
            if file.blob.byte_size > 50*1024*1024
                errors[:base] << 'File more 50Mb'
                false
            end
        end
    end

end
