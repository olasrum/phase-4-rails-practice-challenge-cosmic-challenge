class ScientistsController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
 rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        scientists = Scientist.all
        render json: scientists
    end

    def show
        scientist = find_scientist
        render json: scientist, serializer: ScientistPlanetsSerializer
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        scientist = find_scientist
        scientist.update!(scientist_params)
        render json: scientist, status: :accepted
    end

    def destroy
        scientist = find_scientist
        scientist.destroy
        head :no_content
    end
        

    private

    def find_scientist
        Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

    def render_not_found_response
        render json: {error: "Scientist not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
