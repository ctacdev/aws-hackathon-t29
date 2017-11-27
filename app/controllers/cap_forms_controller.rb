class CapFormsController < ApplicationController
  #before_action :authenticate_user!


  def new
    @capform = CapForm.new
  end

  def create
    @capform = CapForm.new(secure_params)
    CapBuilder.send_message_to_slack_form_form(@capform)
    redirect_to new_cap_form_path
  end

  private

  def admin_only
    unless current_user.admin? 
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:cap_form).permit(:sender,
      :status,
      :message_type,
      :scope,
      :info_event,
      :info_language,
      :info_urgency,
      :info_severity,
      :info_certainty,
      :info_headline,
      :info_description,
      :area_description,
      :area_geocode_name,
      :area_geocode,
      info_categories:[]
    )
  end

end
