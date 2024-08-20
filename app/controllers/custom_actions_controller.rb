# frozen_string_literal: true

class CustomActionsController < ApplicationController
  before_action :set_webhook
  before_action :set_custom_action, only: %i[show edit update destroy sort]

  # GET /custom_actions or /custom_actions.json
  def index
    @custom_actions = @webhook.custom_actions.all
  end

  # GET /custom_actions/1 or /custom_actions/1.json
  def show; end

  def sort
    @custom_action.insert_at(params[:position].to_i)
    head :ok
  end

  def incoming_variables
    @custom_action = if params[:custom_action_id]
                       @webhook.custom_actions.find params[:custom_action_id]
                     else
                       @webhook.custom_actions.new
                     end
    @incoming_variables = @custom_action.could_used_variable_names
  end

  # GET /custom_actions/new
  def new
    @custom_action = @webhook.custom_actions.new(category: params[:category])
    @request_variables = @custom_action.could_used_variable_names
    @url = webhook_custom_actions_path(@webhook.uuid)
  end

  # GET /custom_actions/1/edit
  def edit
    @request_variables = @custom_action.could_used_variable_names
    @url = webhook_custom_action_path(@webhook.uuid, @custom_action)
  end

  # POST /custom_actions or /custom_actions.json
  def create
    @custom_action = @webhook.custom_actions.create(custom_action_params)

    respond_to do |format|
      if @custom_action.save
        format.html do
          redirect_to [@webhook, @custom_action.becomes(CustomAction)],
                      notice: 'Custom action was successfully created.'
        end
        format.json { render :show, status: :created, location: @custom_action }
      else
        @request_variables = @custom_action.could_used_variable_names

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @custom_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_actions/1 or /custom_actions/1.json
  def update
    respond_to do |format|
      if @custom_action.update(custom_action_params)
        format.html do
          redirect_to webhook_custom_actions_path(@webhook),
                      notice: 'Custom action was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @custom_action }
      else

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @custom_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_actions/1 or /custom_actions/1.json
  def destroy
    @custom_action.destroy
    respond_to do |format|
      format.html do
        redirect_to webhook_custom_actions_url(@webhook.uuid),
                    notice: 'Custom action was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def exec_script
    @custom_action = CustomAction.find(params[:custom_action_id])
    @request_variables = @custom_action.could_used_variable_names
    content = params[:content] || @custom_action.script_content

    answer = @custom_action.execute({ script_content: content }, {})
    render json: { answer: }
  end

  private

  def set_webhook
    @webhook = if current_user
                 Webhook.where(user_id: current_user.id).fetch(params[:webhook_id])
               else
                 Webhook.fetch(params[:webhook_id])
               end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_custom_action
    @custom_action = CustomAction.find params[:id]
  end

  # Only allow a list of trusted parameters through.
  def custom_action_params
    category = params[:custom_action][:category]
    case category
    when 'CustomAction::Variable'
      params.require(:custom_action).permit(:category, :position, :title,
                                            :input_from_variable, :input_name, :input_category, :input_filter_val)
    when 'CustomAction::Request'
      params.require(:custom_action).permit(:category, :position, :title,
                                            :input_url, :input_method, :input_trigger_condition, :input_content_type,
                                            :input_body, :input_response_head_code, :input_response_body)
    when 'CustomAction::Script'
      params.require(:custom_action).permit(:category, :position, :title, :script_content)
    end
  end
end
