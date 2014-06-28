class LeaguesController < ApplicationController

  def index
  end

  def show
    @league = League.lookup(params[:id])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)
    if @league.save
      @league.build_fixtures
      redirect_to league_path(@league)
    else
      render 'new'
    end
  end

  private

  def league_params
    params.require(:league).permit(:name,
    teams_attributes: [:id, :name, :_destroy])
  end
end
