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

  # GET /custom_actions/new
  def new
    @custom_action = @webhook.custom_actions.new(category: params[:category])
    @url = webhook_custom_actions_path(@webhook.uuid)
  end

  # GET /custom_actions/1/edit
  def edit
    @request_variables = @custom_action.could_used_variable_names
    @url = new_webhook_custom_action_path(@webhook.uuid, @custom_action)
  end

  # POST /custom_actions or /custom_actions.json
  def create
    @custom_action = @webhook.custom_actions.create(custom_action_params)

    respond_to do |format|
      if @custom_action.save
        format.html { redirect_to [@webhook, @custom_action.becomes(CustomAction)], notice: 'Custom action was successfully created.' }
        format.json { render :show, status: :created, location: @custom_action }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @custom_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_actions/1 or /custom_actions/1.json
  def update
    respond_to do |format|
      if @custom_action.update(custom_action_params)
        format.html { redirect_to webhook_custom_actions_path(@webhook), notice: 'Custom action was successfully updated.' }
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
      format.html { redirect_to custom_actions_url, notice: 'Custom action was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_webhook
    if current_user
      @webhook = Webhook.where(user_id: current_user.id).find_by_id_or_uuid(params[:webhook_id])
    else
      @webhook = Webhook.where(webhook_token: cookie_webhook_token).find_by_id_or_uuid(params[:webhook_id])
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_custom_action
    @custom_action = CustomAction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def custom_action_params
    if params[:custom_action][:category] == 'CustomAction::Variable'
      params.require(:custom_action).permit(:category,:position,  :title, :input_from_variable, :input_name, :input_category, :input_filter_val)
    elsif params[:custom_action][:category] == 'CustomAction::Request'
      params.require(:custom_action).permit(:category, :position, :title, :input_url, :input_method, :input_content_type, :input_body)
    end
  end
end
