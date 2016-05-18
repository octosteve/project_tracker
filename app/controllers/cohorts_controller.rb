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

  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.destroy!
    redirect_to root_path, notice: "#{@cohort.name} successfully deleted"
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end
end
