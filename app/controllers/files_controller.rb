# frozen_string_literal: true

class FilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_file
  before_action :find_record

  def destroy
    @file.purge if current_user.author_of?(@record)
  end

  private

  def find_file
    @file = ActiveStorage::Attachment.find(params[:id])
  end

  def find_record
    @record = @file.record_type.constantize.find(@file.record_id)
  end
end
