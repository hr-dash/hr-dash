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

    def active_admin_action_log
      before_destroy do |model|
        ActiveAdminActionLog.create! do |log|
          log.user = current_user
          log.resource = model
          log.path = resource_path
          log.action = action_name
        end
      end

      before_save do |model|
        @active_admin_action_log = ActiveAdminActionLog.new do |log|
          log.user = current_user
          log.action = action_name
          log.changes_log = model.changes if model.changes.present?
        end
      end

      after_save do |model|
        @active_admin_action_log.update!(resource: model, path: resource_path) if model.valid?
      end
    end
  end
end
