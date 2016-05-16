class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
    @project = Project.new
  end

  def create
    cohort = Cohort.new(cohort_params)
    if cohort.save
      redirect_to cohort
    else
      redirect_to cohorts_path
    end
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end
end
