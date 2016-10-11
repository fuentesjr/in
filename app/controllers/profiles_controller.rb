class ProfilesController < ApplicationController
  def index
  end

  def search
    results = []

    if params[:search_field] == "fullname"
      results = Profile.where("LOWER(fullname) LIKE ?", "#{params['query'].downcase}%")
    end

    render json: { results: results }
  end

  def create
    profile = Profile.new(profile_params)
    if profile.save
      render json: {status: :created}, status: :created
    else
      render json: {status: :unprocessable_entity}, status: :unprocessable_entity
    end
  end

  private

    def profile_params
      params.require(:profile).permit(:fullname, :title, :company, :position, :url)
    end
end
