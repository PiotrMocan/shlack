class UserExportsController < ApplicationController
  expose :user_export, -> { UserExport.find_by(id: params[:id]) }

  def show
    if user_export
      render json: user_export, serializer: UserExportSerializer, status: 200
    else
      render json: { errors: 'User export not found' }, status: 404
    end
  end

  def create
    last_table_updated_at = User.select("MAX(MAX(created_at),  MAX(updated_at)) as last_table_updated_at").first.last_table_updated_at

    if user_export = UserExport.where('created_at > ?', last_table_updated_at).last
      return render json: user_export, serializer: UserExportSerializer, status: 200
    end

    user_export = UserExport.new
    UserExport.transaction do
      user_export.save!
      Users::GenerateCsvWorker.perform_async(user_export.id)
    end

    render json: user_export, serializer: UserExportSerializer, status: 200
  end
end
