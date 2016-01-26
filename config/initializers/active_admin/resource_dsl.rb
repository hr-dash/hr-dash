module ActiveAdmin
  class ResourceDSL
    def csv_importable(options = {})
      active_admin_import({
        validate: true,
        batch_transaction: true,
        template_object: ActiveAdminImport::Model.new(
          force_encoding: :auto
        ),
      }.merge!(options))
    end
  end
end
