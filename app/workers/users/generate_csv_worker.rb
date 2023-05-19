require 'csv'
class Users::GenerateCsvWorker
  include Sidekiq::Worker

  def perform(id, options = {})
    user_export = UserExport.find_by(id: id)
    return unless user_export

    csv_data = CSV.generate do |csv|
      csv << ['id', 'name', 'email']
      User.find_each do |user|
        current_user = user.account
        csv << [user.id, user.name, current_user.email]
      end
    end

    user_export.file.attach(
      io: StringIO.new(csv_data),
      filename: "users-#{Time.zone.now.to_i}.csv",
      content_type: 'text/csv'
    )
    user_export.is_ready = true
    user_export.save!
  end
end
