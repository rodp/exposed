module Exposed
  class Base < ActionController::Base

    before_filter :process_params

    rescue_from Exception, with: :exception_caught

    def initialize
      # E.g. 'UsersController' will yield 'User'
      model_name = self.class.name.sub("Controller", "").singularize
      # The model class, should extend ActiveRecord::Base
      @model     = model_name.constantize
      # The model symbol, used to extract parameters
      @model_sym = model_name.downcase.to_sym
    end

    # GET /collection
    def index
      filters = params.except(:controller, :action, :include, :exclude)
      collection = @model.where(filters).includes(@include)
      render_response collection
    end

    # GET /collection/id
    def show
      record = @model.find(params[:id])
      render_response record
    end

    # POST /collection
    def create
      record = @model.new(params[@model_sym])
      record.save!
      render_response record
    end

    # PUT /collection/id
    def update
      record = @model.find(params[:id])
      record.update_attributes!(params[@model_sym])
      render_response record
    end

    # DELETE /collection/id
    def destroy
      render_response @model.destroy(params[:id])
    end

    protected

    def process_params
      # Support comma-separated arrays for these params
      [:include, :exclude].each do |key|
        params[key] = params[key].split(",") if params.has_key?(key) and params[key].kind_of?(String)
      end

      # Exclude/include attributes and associations
      @exclude = (params[:exclude] or [])
      @include = (params[:include] or []) - @exclude
    end

    def exception_caught (e)
      case e
      when ActiveRecord::RecordNotFound
        status = 404
      when ActiveRecord::RecordInvalid
        status = 400
      else
        status = 500
      end

      render_error status, e
    end

    def render_response (object)
      render json: object.as_json(include: @include, except: @exclude, controller: params[:controller], action: params[:action])
    end

    def render_error (status, e)
      render status: status, json: e
    end

  end
end
