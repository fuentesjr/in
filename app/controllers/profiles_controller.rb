class ProfilesController < ApplicationController
  def index
    # Init data used to bootstrap Elm front-end application (SPA)
    @init_search = {
      searchQuery: "",
      searchPath: search_profiles_path,
      searchField: "fullname",
      searchResults: []
    }
  end

  def search
    results = []

    if %w(fullname skills).include?(params[:search_field])
      if params[:search_field] == "fullname"
        results = Profile.
                  where("LOWER(fullname) LIKE ?", "#{params['query'].downcase}%").
                  includes(:skills)
      else # search by skills
        results = Profile.joins(:skills).merge(Skill.where("name = ?", params['query']))
      end
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
