class ScientistsController < ApplicationController

    before_action :set_scientist, only: [:show, :update, :destroy]


    def index
        render json: Scientist.all
      end
    
      def show
        scientist = find_scientist
        render json: scientist, serializer: ScientistWithMissionsSerializer
      end
    
      def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
      end
    
    
      def destroy
        scientist = find_scientist
        scientist.destroy
        head :no_content
      end

      def update
        @scientist.update!(scientist_params)
        render json: @scientist, status: :accepted
    end
    
      private

      def set_scientist
        @scientist = Scientist.find(params[:id])
    end
    
      def scientist_params
        params.permit(:name, :field_of_study, :avatar)
      end
    
      def find_scientist
        Scientist.find(params[:id])
      end
    
      def render_not_found_response
        render json: { error: "Scientist not found" }, status: :not_found
      end
    
      def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
    
end
