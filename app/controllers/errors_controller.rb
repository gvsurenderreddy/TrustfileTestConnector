class ErrorsController < AuthenticatedController
  before_action :set_errors, only: [:show]

  def show
    respond_to do |format|
      format.json { render json: @errors}
    end
  end

  private
    # respond with errors from date
    # OR by default respond with errors from today
    def set_errors
      @errors = nil
      begin
        errors_after_date = Date.parse(params['date'])
        @errors = Error.where("error_timestamp > ?", errors_after_date) if errors_after_date.is_a?(Date)
        @errors = Error.where("error_timestamp > ?", Date.today) unless errors_after_date.is_a?(Date)
      rescue
        @errors = Error.where("error_timestamp > ?", Date.today) unless errors_after_date.is_a?(Date)
      end
    end

end
